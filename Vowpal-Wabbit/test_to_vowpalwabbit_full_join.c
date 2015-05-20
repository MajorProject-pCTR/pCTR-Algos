#include<stdio.h>
#include<stdlib.h>

int main(){
	int i;
	int click,impression;
	int ad_url_freq, ad_id_freq, adv_id_freq, user_id_freq, gender, age, description_id_freq, desc_id_tokencnt, title_id_freq, titid_tokencnt, keyword_id_freq, purc_k_id_tokencnt, query_id_freq, qid_tokencnt;
	int depth,position;
	float ctr;
	FILE *fp1=fopen("test_processed.txt","r");
	FILE *fp2=fopen("test.data.vw","w");
	for(i=1;i<=29927821;i++){
		fscanf(fp1, " %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", &click, &impression, &depth, &position, &ad_url_freq, &ad_id_freq, &adv_id_freq, &user_id_freq, &gender, &age, &description_id_freq, &desc_id_tokencnt, &title_id_freq, &titid_tokencnt, &keyword_id_freq, &purc_k_id_tokencnt, &query_id_freq, &qid_tokencnt);
		ctr = (click * 1.0)/(impression * 1.0);
		fprintf(fp2, " %f | DEP:%d POS:%d ADURL:%d ADID:%d ADVERID:%d USERID:%d GEN:%d AGE:%d DESCID:%d DESCTKN:%d TID:%d TTKN:%d KID:%d PTKN:%d QID:%d QTKN:%d\n", ctr, depth, position, ad_url_freq, ad_id_freq, adv_id_freq, user_id_freq, gender, age, description_id_freq, desc_id_tokencnt, title_id_freq, titid_tokencnt, keyword_id_freq, purc_k_id_tokencnt, query_id_freq, qid_tokencnt);
	}
	fclose(fp1);
	fclose(fp2);
	return 0;
}
