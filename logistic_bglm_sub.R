logistic_bglm_sub <- function(all=TRUE) {

	library(biglm)
	start <- Sys.time()
	ad_data <- read.table("unrolled_sub.txt")
	end <- Sys.time()
	diff <- end - start

	names(ad_data) <- c("index", "if_click", "ad_id", "advertiser_id", "depth", "position", "query_id", "keyword_id", "title_id", "desc_id", "user_id")

	ad_data <- normalize(ad_data)$data

	#print(head(ad_data,3))

	ad_data$click <- 0
	ad_data$impression <- 0
	ad_data$ad_urlhash <- 0
	
	print("Unrolled data ready")
	print("time taken")
	print(diff)

	if(all){
		start <- Sys.time()
		glm <- bigglm(if_click~ad_id+advertiser_id+depth+position+query_id+keyword_id+title_id+desc_id+user_id, data=ad_data, family=binomial())
		print(summary(glm))
		end <- Sys.time()
	}
	else{
		start <- Sys.time()
		glm <- bigglm(if_click~depth+position, data=ad_data, family=binomial())
		print(summary(glm))
		end <- Sys.time()
	}

	diff <- end - start
	print("Model trained")
	print("time taken")
	print(diff)


	print("Prediction on training data")

	start <- Sys.time()
	ad_data <- read.table("train_80_sub.txt")
	end <- Sys.time()
	print("Loaded the data")
	print("time taken")
	diff <- end - start
	print(diff)

	names(ad_data) <- c("click", "impression", "ad_urlhash", "ad_id", "advertiser_id", "depth", "position", "query_id", "keyword_id", "title_id", "desc_id", "user_id")

	n_data <- normalize(ad_data)

	ad_data <- n_data$data
	mu <- n_data$mu
	stddev <- n_data$stddev

	rm(n_data)

	#print(head(ad_data,5))
	#print(mu)
	#print(stddev)

	ad_data$if_click <- 0
	ad_data$index <- 0
	
	start <- Sys.time()
	h<-predict(glm,ad_data)
	end <- Sys.time()
	print("time taken for obtaining predictions")
	diff <- end - start
	print(diff)

	start <- Sys.time()
	write(h,file="pred_train_sub.csv",sep="\n")
	end <- Sys.time()
	print("time taken for writing predictions")
	diff <- end - start
	print(diff)


	print("Prediction on test data")		

	start <- Sys.time()
	ad_data <- read.table("test_sub.txt")
	end <- Sys.time()
	print("Loaded the data")
	print("time taken")
	diff <- end - start
	print(diff)

	names(ad_data) <- c("click", "impression", "ad_urlhash", "ad_id", "advertiser_id", "depth", "position", "query_id", "keyword_id", "title_id", "desc_id", "user_id")

	ad_data <- normalize2(ad_data, mu, stddev)
	#print(head(ad_data,5))

	ad_data$if_click <- 0
	ad_data$index <- 0
	
	start <- Sys.time()
	h<-predict(glm,ad_data)
	end <- Sys.time()
	print("time taken for obtaining predictions")
	diff <- end - start
	print(diff)

	start <- Sys.time()
	write(h,file="pred_test_sub.csv",sep="\n")
	end <- Sys.time()
	print("time taken for writing predictions")
	diff <- end - start
	print(diff)
}

normalize <- function(data) {

	mu <- list()
	stddev <- list()

	for(n in names(data)){
		if(n!="if_click" & n!="index"){
			#print(n)
			mu[[n]] <- mean(data[[n]])
			stddev[[n]] <- sd(data[[n]])	

			data[[n]] <- (data[[n]]-mu[[n]])/stddev[[n]]
		}			
	}

	list(data=data, mu=mu, stddev=stddev)
}

normalize2 <- function(data, mu, stddev) {

	for(n in names(data)){
		if(n != "if_click" & n != "index"){
			#print(n)
			data[[n]] <- (data[[n]]-mu[[n]])/stddev[[n]]	
		}			
	}

	data
}
