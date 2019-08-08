base_model_path="app/views"
base_model="departments"
base_controller_path="app/controllers"
base_controller="$base_controller_path/$base_model"s_controller.rb
model=$2

mkdirp app/views/"$2"s

echo "Copying views from $base_model_path/"$base_model"s/ to $base_model_path/"$model"s/"
sed 's/'$base_model'/'$model'/g' $base_model_path/"$base_model"s/index.html.erb > $base_model_path/"$model"s/index.html.erb
sed 's/'$base_model'/'$model'/g' $base_model_path/"$base_model"s/create.js.erb > $base_model_path/"$model"s/create.js.erb
sed 's/'$base_model'/'$model'/g' $base_model_path/"$base_model"s/edit.js.erb > $base_model_path/"$model"s/edit.js.erb

echo "Copying controller from $base_controller to $base_model_path/"$model"s_controller"
sed 's/'$base_model'/'$model'/g' $base_model_path/"$base_model"s/create.json.rabl > $base_model_path/"$model"s/edit.js.erb
