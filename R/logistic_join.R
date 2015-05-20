logistic_join <- function() {

	library(biglm)
	start <- Sys.time()
	ad_data <- read.table("unrolled_processed.txt")
	end <- Sys.time()
	diff <- end - start

	names(ad_data) <- c("if_click", "depth", "position", "ad_url_freq", "ad_id_freq", "adv_id_freq", "user_id_freq", "gender", "age", "desc_id_freq", "desc_id_tokencnt", "t_id_freq", "t_id_tokencnt", "k_id_freq",  "k_id_tokencnt", "qid_freq", "qid_tokencnt")

	#n ad_data <- normalize(ad_data)$data

	#print(head(ad_data,3))

	ad_data$click <- 0
	ad_data$impression <- 0

	ad_data$gender <- as.factor(ad_data$gender)
	ad_data$age <- as.factor(ad_data$age)
	ad_data$depth <- as.factor(ad_data$depth)
	ad_data$position <- as.factor(ad_data$position)
	
	print("Unrolled data ready")
	print("time taken")
	print(diff)

	start <- Sys.time()
	glm <- bigglm(if_click~depth+position+ad_url_freq+ad_id_freq+adv_id_freq+user_id_freq+gender+age+desc_id_freq+desc_id_tokencnt+t_id_freq+t_id_tokencnt+k_id_freq+k_id_tokencnt+qid_freq+qid_tokencnt, data=ad_data, family=binomial(), chunksize=300000)
	print(summary(glm))
	end <- Sys.time()

	diff <- end - start
	print("Model trained")
	print("time taken")
	print(diff)

	rm(ad_data)

	print("Prediction on training data")

	start <- Sys.time()
	ad_data <- read.table("train_processed.txt")
	end <- Sys.time()
	print("Loaded the data")
	print("time taken")
	diff <- end - start
	print(diff)

	names(ad_data) <- c("click", "impression", "depth", "position", "ad_url_freq", "ad_id_freq", "adv_id_freq", "user_id_freq", "gender", "age", "desc_id_freq", "desc_id_tokencnt", "t_id_freq", "t_id_tokencnt", "k_id_freq",  "k_id_tokencnt", "qid_freq", "qid_tokencnt")

	ad_data$gender <- as.factor(ad_data$gender)
	ad_data$age <- as.factor(ad_data$age)
	ad_data$depth <- as.factor(ad_data$depth)
	ad_data$position <- as.factor(ad_data$position)

	#n n_data <- normalize(ad_data)

	#n ad_data <- n_data$data
	#n mu <- n_data$mu
	#n stddev <- n_data$stddev

	#n rm(n_data)

	#print(head(ad_data,5))
	#print(mu)
	#print(stddev)

	ad_data$if_click <- 0
	
	start <- Sys.time()
	h<-predict(glm,ad_data)
	end <- Sys.time()
	print("time taken for obtaining predictions")
	diff <- end - start
	print(diff)

	start <- Sys.time()
	write(h,file="pred_trainpro_log.csv",sep="\n")
	end <- Sys.time()
	print("time taken for writing predictions")
	diff <- end - start
	print(diff)

	rm(ad_data)
	rm(h)

	print("Prediction on test data")		

	start <- Sys.time()
	ad_data <- read.table("test_processed.txt")
	end <- Sys.time()
	print("Loaded the data")
	print("time taken")
	diff <- end - start
	print(diff)

	names(ad_data) <- c("click", "impression", "depth", "position", "ad_url_freq", "ad_id_freq", "adv_id_freq", "user_id_freq", "gender", "age", "desc_id_freq", "desc_id_tokencnt", "t_id_freq", "t_id_tokencnt", "k_id_freq",  "k_id_tokencnt", "qid_freq", "qid_tokencnt")

	ad_data$gender <- as.factor(ad_data$gender)
	ad_data$age <- as.factor(ad_data$age)
	ad_data$depth <- as.factor(ad_data$depth)
	ad_data$position <- as.factor(ad_data$position)

	#n ad_data <- normalize2(ad_data, mu, stddev)
	#print(head(ad_data,5))

	ad_data$if_click <- 0
	
	start <- Sys.time()
	h<-predict(glm,ad_data)
	end <- Sys.time()
	print("time taken for obtaining predictions")
	diff <- end - start
	print(diff)

	start <- Sys.time()
	write(h,file="pred_testpro_log.csv",sep="\n")
	end <- Sys.time()
	print("time taken for writing predictions")
	diff <- end - start
	print(diff)

	rm(ad_data)
	rm(h)
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
