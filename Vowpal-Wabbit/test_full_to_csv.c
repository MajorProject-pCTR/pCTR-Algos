#include<stdio.h>
#include<stdlib.h>

int main(){
	int i;
	int click,impression;
	char display_url[50],ad_id[20],advertiser_id[20],query_id[20],keyword_id[20],title_id[20],description_id[20],user_id[20];
	int depth,position;
	float ctr;
	FILE *fp1=fopen("test_full.txt","r");
	FILE *fp2=fopen("test_full.csv","w");
	for(i=1;i<=29927821;i++){
		fscanf(fp1, " %d %s %s %s %d %d %s %s %s %s %s", &click, display_url, ad_id, advertiser_id, &depth, &position, query_id, keyword_id, title_id, description_id, user_id);
		fprintf(fp2, " %d,%s,%s,%s,%d,%d,%s,%s,%s,%s,%s\n", click, display_url, ad_id, advertiser_id, depth, position, query_id, keyword_id, title_id, description_id, user_id);
	}
	fclose(fp1);
	fclose(fp2);
	return 0;
}
