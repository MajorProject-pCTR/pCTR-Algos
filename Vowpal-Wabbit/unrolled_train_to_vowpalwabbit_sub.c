#include<stdio.h>
#include<stdlib.h>

int main(){
	int i;
	int click,impression,slno;
	char display_url[50],ad_id[20],advertiser_id[20],query_id[20],keyword_id[20],title_id[20],description_id[20],user_id[20];
	int depth,position;
	float ctr;
	FILE *fp1=fopen("train_unrolled_sub.txt","r");
	FILE *fp2=fopen("input.data.vw","w");
	for(i=1;i<=3320848;i++){
		fscanf(fp1, " %d %d %s %s %s %d %d %s %s %s %s %s",&slno, &click, display_url, ad_id, advertiser_id, &depth, &position, query_id, keyword_id, title_id, description_id, user_id);
		if(click == 0){
			fprintf(fp2, "-1 | SLNO:%d ADID:%s ADVERID:%s DEP:%d POS:%d QID:%s KID:%s TID:%s DID:%s UID:%s\n", slno, ad_id, advertiser_id, depth, position, query_id, keyword_id, title_id, description_id, user_id);
		}
		else{
			fprintf(fp2, "1 | SLNO:%d ADID:%s ADVERID:%s DEP:%d POS:%d QID:%s KID:%s TID:%s DID:%s UID:%s\n", slno, ad_id, advertiser_id, depth, position, query_id, keyword_id, title_id, description_id, user_id);
		}
	}
	fclose(fp1);
	fclose(fp2);
	return 0;
}
