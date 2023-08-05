# Run Tamil POS tagger and Chunker and save the output to a file.
input_file=$1
pos_model_path=$2
chunk_model_path=$3
output_file=$4
# extract the file name
input_file_name=$(echo $input_file | sed 's/\.txt//')
feature_path=$input_file_name"-features-for-pos"
python3 create_features_for_pos_tagging.py --input $input_file --output $feature_path
pred_pos_path=$input_file_name"-features-with-predicted-pos"
crf_test -m $pos_model_path $feature_path > $pred_pos_path
token_pred_pos_path="temp.pos"
cut -f1,14 $pred_pos_path > $token_pred_pos_path
crf_test -m $chunk_model_path $token_pred_pos_path > $output_file
rm -rf $feature_path $pred_pos_path $token_pred_pos_path
