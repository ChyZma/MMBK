java -jar openapi-generator-cli-6.0.0.jar generate \
  -i swagger2.yaml \
  -g dart \
  -o ../gen/api \
  -c api_config.yaml \
  --global-property apis,models,supportingFiles,apiTests=false,modelTests=false
