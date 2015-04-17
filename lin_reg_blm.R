lin_reg_blm <- function() {

	library(biglm)
	start <- Sys.time()
	ad_data <- read.table("train_sub.txt")
	end <- Sys.time()

	diff <- end - start

	names(ad_data) <- c("click", "impression", "ad_urlhash", "ad_id", "advertiser_id", "depth", "position", "query_id", "keyword_id", "title_id", "desc_id", "user_id")

	print("Loaded the data")
	print("time taken")
	print(diff)

	start <- Sys.time()
	lm <- biglm(click/impression~ad_id+advertiser_id+depth+position+query_id+keyword_id+title_id+desc_id+user_id, ad_data[1:200000,])
	lm <- update(lm, ad_data[200001:400000,])
	lm <- update(lm, ad_data[400001:600000,])
	end <- Sys.time()


	print("Model trained")

	print("time taken")
	diff <- end - start
	print(diff)
	
	start <- Sys.time()
	h<-predict(lm,ad_data)
	end <- Sys.time()
	print("time taken for obtaining predictions")
	diff <- end - start
	print(diff)

	start <- Sys.time()
	write(h,file="pred_train_full.csv",sep="\n")
	end <- Sys.time()
	print("time taken for writing predictions")
	diff <- end - start
	print(diff)

	rm(h)

	start <- Sys.time()
	ad_data <- read.table("test_orig_sub.txt")
	end <- Sys.time()
	diff <- end - start

	print("Loaded test data")
	print("time taken")
	print(diff)

	names(ad_data) <- c("ad_urlhash", "ad_id", "advertiser_id", "depth", "position", "query_id", "keyword_id", "title_id", "desc_id", "user_id")
	ad_data$click <- 0
	ad_data$impression <- 1
	
	start <- Sys.time()
	h<-predict(lm,ad_data)
	end <- Sys.time()
	print("time taken for obtaining predictions")
	diff <- end - start
	print(diff)

	start <- Sys.time()
	write(h,file="pred_test_orig.csv",sep="\n")
	end <- Sys.time()
	print("time taken for writing predictions")
	diff <- end - start
	print(diff)

	rm(h)
}
