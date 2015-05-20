lr_blm_sub <- function() {

	library(biglm)
	start <- Sys.time()
	ad_data <- read.table("train_80_sub.txt")
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
	lm <- update(lm, ad_data[600001:800000,])	
	end <- Sys.time()

	print(summary(lm))
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
	write(h,file="pred_train_sub.csv",sep="\n")
	end <- Sys.time()
	print("time taken for writing predictions")
	diff <- end - start
	print(diff)

	rm(h)

	start <- Sys.time()
	ad_data <- read.table("test_sub.txt")
	end <- Sys.time()
	diff <- end - start

	print("Loaded test data")
	print("time taken")
	print(diff)

	names(ad_data) <- c("click", "impression", "ad_urlhash", "ad_id", "advertiser_id", "depth", "position", "query_id", "keyword_id", "title_id", "desc_id", "user_id")
	
	start <- Sys.time()
	h<-predict(lm,ad_data)
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

	rm(h)
}
