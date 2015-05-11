#include<iostream>
#include<fstream>
#include<string>

#define MAX 50
#define ID_L 20

using namespace std;

int main(){
	int click, impression, depth, position, i, j, index, ad_url_freq, user_id_freq, gender, age, description_id_freq, desc_id_tokencnt, title_id_freq, titid_tokencnt, keyword_id_freq, purc_k_id_tokencnt, query_id_freq, qid_tokencnt;
	char display_url[MAX], ad_id[ID_L], advertiser_id[ID_L], query_id[ID_L], keyword_id[ID_L], title_id[ID_L], description_id[ID_L], user_id[ID_L];
	ifstream input_file ("train_final.txt");
	ofstream output_file ("unrolled.txt");
	
	index = 1;

	if(input_file.is_open() && output_file.is_open()){
		while(true){

			input_file >> click >> impression >> ad_id >> advertiser_id >> depth >> position >> ad_url_freq >> user_id_freq >> gender >> age >> description_id_freq >> desc_id_tokencnt >> title_id_freq >> titid_tokencnt >> keyword_id_freq >> purc_k_id_tokencnt >> query_id_freq >> qid_tokencnt;	

			if(input_file.eof())
				break;

			for(j=1; j<=click; ++j){
				output_file << 1 << " " << ad_id << " " << advertiser_id << " " << depth  << " " << position << " " << ad_url_freq << " " << user_id_freq << " " << gender << " " << age << " " << description_id_freq << " " << desc_id_tokencnt << " " << title_id_freq << " " << titid_tokencnt << " " << keyword_id_freq << " " << purc_k_id_tokencnt << " " << query_id_freq << " " << qid_tokencnt << "\n";
				index++;
			}
	
			for(j=1; j<=impression-click; ++j){
				output_file << 0 << " " << ad_id << " " << advertiser_id << " " << depth  << " " << position << " " << ad_url_freq << " " << user_id_freq << " " << gender << " " << age << " " << description_id_freq << " " << desc_id_tokencnt << " " << title_id_freq << " " << titid_tokencnt << " " << keyword_id_freq << " " << purc_k_id_tokencnt << " " << query_id_freq << " " << qid_tokencnt << "\n";
				index++;
			}

		}
		input_file.close();
		output_file.close();
	}
	else
		printf("Could not open file\n");
	
	return 0;
}	
