lr_join <- function() {

	library(biglm)
	start <- Sys.time()
	ad_data <- read.table("train_processed.txt")
	end <- Sys.time()

	diff <- end - start

	names(ad_data) <- c("click", "impression", "depth", "position", "ad_url_freq", "ad_id_freq", "adv_id_freq", "user_id_freq", "gender", "age", "desc_id_freq", "desc_id_tokencnt", "t_id_freq", "t_id_tokencnt", "k_id_freq",  "k_id_tokencnt", "qid_freq", "qid_tokencnt")

	ad_data$gender <- as.factor(ad_data$gender)
	ad_data$age <- as.factor(ad_data$age)
	ad_data$depth <- as.factor(ad_data$depth)
	ad_data$position <- as.factor(ad_data$position)

	print("Loaded the data")
	print("time taken")
	print(diff)

	start <- Sys.time()
	lm <- biglm(click/impression ~ depth+position+ad_url_freq+ad_id_freq+adv_id_freq+user_id_freq+gender+age+desc_id_freq*desc_id_tokencnt+t_id_freq*t_id_tokencnt+k_id_freq*k_id_tokencnt+qid_freq*qid_tokencnt, ad_data[1:30000000,])
	lm <- update(lm, ad_data[30000001:60000000,])
	lm <- update(lm, ad_data[60000001:90000000,])
	lm <- update(lm, ad_data[90000001:119711284,])	
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
	write(h,file="pred_trainpro.csv",sep="\n")
	end <- Sys.time()
	print("time taken for writing predictions")
	diff <- end - start
	print(diff)

	rm(h)

	start <- Sys.time()
	ad_data <- read.table("test_processed.txt")
	end <- Sys.time()
	diff <- end - start

	print("Loaded test data")
	print("time taken")
	print(diff)

	names(ad_data) <- c("click", "impression", "depth", "position", "ad_url_freq", "ad_id_freq", "adv_id_freq", "user_id_freq", "gender", "age", "desc_id_freq", "desc_id_tokencnt", "t_id_freq", "t_id_tokencnt", "k_id_freq",  "k_id_tokencnt", "qid_freq", "qid_tokencnt")

	ad_data$gender <- as.factor(ad_data$gender)
	ad_data$age <- as.factor(ad_data$age)
	ad_data$depth <- as.factor(ad_data$depth)
	ad_data$position <- as.factor(ad_data$position)
	
	start <- Sys.time()
	h<-predict(lm,ad_data)
	end <- Sys.time()
	print("time taken for obtaining predictions")
	diff <- end - start
	print(diff)

	start <- Sys.time()
	write(h,file="pred_testpro.csv",sep="\n")
	end <- Sys.time()
	print("time taken for writing predictions")
	diff <- end - start
	print(diff)

	rm(h)
}
