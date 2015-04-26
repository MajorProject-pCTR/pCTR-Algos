lin_reg_full <- function(all=TRUE) {

	start <- Sys.time()
	ad_data <- read.table("train_final.txt")
	end <- Sys.time()

	diff <- end - start

	names(ad_data) <- c("click", "impression", "ad_urlhash", "ad_id", "advertiser_id", "depth", "position", "query_id", "keyword_id", "title_id", "desc_id", "user_id")

	print("Loaded the data")
	print("time taken")
	print(diff)

	if(all){
		start <- Sys.time()
		lm.fit <- lm(click/impression~ad_id+advertiser_id+depth+position+query_id+keyword_id+title_id+desc_id+user_id, data=ad_data)
		end <- Sys.time()
	}
	else{
		start <- Sys.time()
		lm.fit <- lm(click/impression~depth+position, data=ad_data)
		end <- Sys.time()
	}

	print("Model trained")

	print("time taken")
	diff <- end - start
	print(diff)

	rm(ad_data)
	
	start <- Sys.time()
	h<-predict(lm.fit)
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
	ad_data <- read.table("test_final.txt")
	end <- Sys.time()
	diff <- end - start

	print("Loaded test data")
	print("time taken")
	print(diff)

	names(ad_data) <- c("click", "impression", "ad_urlhash", "ad_id", "advertiser_id", "depth", "position", "query_id", "keyword_id", "title_id", "desc_id", "user_id")
	
	start <- Sys.time()
	h<-predict(lm.fit,ad_data)
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
