#include<iostream>
#include<fstream>
#include<string>

#define MAX 50
#define ID_L 20

using namespace std;

int main(){
	int gender, age, count;
	long long int userid, index;
	ifstream input_file ("userid_profile.txt");
	
	index = 1;
	count = 0;

	if(input_file.is_open()){
		while(true){

			input_file >> userid >> gender >> age;	

			if(input_file.eof())
				break;
			
			if(index != userid){
				cout << userid << "\n";
				index = userid;

				count++;
				if(count == 5)
					break;
			}

			index++;


		}
		input_file.close();
	}
	else
		printf("Could not open file\n");
	
	return 0;
}	
