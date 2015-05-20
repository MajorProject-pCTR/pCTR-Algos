#include<stdio.h>
#include<stdlib.h>

int main(){
	int i;
	int click,impression;
	char display_url[50],ad_id[20],advertiser_id[20],query_id[20],keyword_id[20],title_id[20],description_id[20],user_id[20];
	int depth,position;
	float ensmbl1,ensmbl2,ensmbl3;
	float ctr;
	FILE *fp1=fopen("pred_train_log.csv","r");
	FILE *fp2=fopen("pred_train_linear.csv","r");
	FILE *fp3=fopen("train_predictions_nn.txt", "r");
	FILE *fp4=fopen("train_final.txt","r");
	FILE *fp5=fopen("input.data.vw","w");
	for(i=1;i<=119711284;i++){
		fscanf(fp1, " %f",&ensmbl1);
		fscanf(fp2, " %f",&ensmbl2);
		fscanf(fp3, " %f",&ensmbl3);
		fscanf(fp4, " %d %d %s %s %s %d %d %s %s %s %s %s", &click, &impression, display_url, ad_id, advertiser_id, &depth, &position, query_id, keyword_id, title_id, description_id, user_id);
		ctr = (click * 1.0)/(impression * 1.0);
		fprintf(fp5, " %f | ADID:%s ADVERID:%s DEP:%d POS:%d QID:%s KID:%s TID:%s DID:%s UID:%s 1:%f 2:%f 3:%f\n",ctr,ad_id, advertiser_id, depth, position, query_id, keyword_id, title_id, description_id, user_id, ensmbl1,ensmbl2,ensmbl3);
	}
	fclose(fp1);
	fclose(fp2);
	fclose(fp3);
	fclose(fp4);
	fclose(fp5);
	return 0;
}
