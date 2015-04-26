logistic <- function(all=TRUE) {
	start <- Sys.time()
	ad_data <- read.table("train_unrolled.txt")
	names(ad_data) <- c("if_click", "ad_urlhash", "ad_id", "advertiser_id", "depth", "position", "query_id", "keyword_id", "title_id", "desc_id", "user_id")

	print("Unrolled data ready")

	if(all){
		start <- Sys.time()
		glm.fit=glm(if_click~ad_id+advertiser_id+depth+position+query_id+keyword_id+title_id+desc_id+user_id, data=ad_data, family=binomial)
		end <- Sys.time()
	}
	else{
		start <- Sys.time()
		glm.fit=glm(if_click~depth+position, data=ad_data, family=binomial)
		end <- Sys.time()
	}

	print("Model trained")

	ad_data <- read.table("train_sub.txt")
	names(ad_data) <- c("click", "impression", "ad_urlhash", "ad_id", "advertiser_id", "depth", "position", "query_id", "keyword_id", "title_id", "desc_id", "user_id")
	glm.probs=predict(glm.fit,ad_data,type="response")
	write(glm.probs,file="pred_train.csv",sep="\n")

	ad_data <- read.table("test_sub.txt")
	names(ad_data) <- c("click", "impression", "ad_urlhash", "ad_id", "advertiser_id", "depth", "position", "query_id", "keyword_id", "title_id", "desc_id", "user_id")
	glm.probs=predict(glm.fit,ad_data,type="response")
	write(glm.probs,file="pred_test.csv",sep="\n")
		end <- Sys.time()
	diff <- end - start

}
