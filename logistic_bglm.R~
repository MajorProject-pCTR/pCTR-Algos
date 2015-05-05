logistic_bglm <- function(all=TRUE) {

	library(biglm)
	start <- Sys.time()
	ad_data <- read.table("unrolled.txt")
	end <- Sys.time()
	diff <- end - start

	names(ad_data) <- c("index", "if_click", "ad_id", "advertiser_id", "depth", "position", "query_id", "keyword_id", "title_id", "desc_id", "user_id")
	ad_data$click <- 0
	ad_data$impression <- 0
	ad_data$ad_urlhash <- 0
	
	print("Unrolled data ready")
	print("time taken")
	print(diff)

	if(all){
		start <- Sys.time()
		glm <- bigglm(if_click~ad_id+advertiser_id+depth+position+query_id+keyword_id+title_id+desc_id+user_id, data=ad_data, family=binomial())
		end <- Sys.time()
	}
	else{
		start <- Sys.time()
		glm <- bigglm(if_click~depth+position, data=ad_data, family=binomial())
		end <- Sys.time()
	}

	diff <- end - start
	print("Model trained")
	print("time taken")
	print(diff)


	print("Prediction on training data")

	start <- Sys.time()
	ad_data <- read.table("train_final.txt")
	end <- Sys.time()
	print("Loaded the data")
	print("time taken")
	diff <- end - start
	print(diff)

	names(ad_data) <- c("click", "impression", "ad_urlhash", "ad_id", "advertiser_id", "depth", "position", "query_id", "keyword_id", "title_id", "desc_id", "user_id")
	ad_data$if_click <- 0
	ad_data$index <- 0

	
	start <- Sys.time()
	h<-predict(lm,ad_data)
	end <- Sys.time()
	print("time taken for obtaining predictions")
	diff <- end - start
	print(diff)

	start <- Sys.time()
	write(h,file="pred_train.csv",sep="\n")
	end <- Sys.time()
	print("time taken for writing predictions")
	diff <- end - start
	print(diff)


	print("Prediction on test data")		

	start <- Sys.time()
	ad_data <- read.table("test_final.txt")
	end <- Sys.time()
	print("Loaded the data")
	print("time taken")
	diff <- end - start
	print(diff)

	names(ad_data) <- c("click", "impression", "ad_urlhash", "ad_id", "advertiser_id", "depth", "position", "query_id", "keyword_id", "title_id", "desc_id", "user_id")
	ad_data$if_click <- 0
	ad_data$index <- 0

	
	start <- Sys.time()
	h<-predict(lm,ad_data)
	end <- Sys.time()
	print("time taken for obtaining predictions")
	diff <- end - start
	print(diff)

	start <- Sys.time()
	write(h,file="pred_test.csv",sep="\n")
	end <- Sys.time()
	print("time taken for writing predictions")
	diff <- end - start
	print(diff)
}
