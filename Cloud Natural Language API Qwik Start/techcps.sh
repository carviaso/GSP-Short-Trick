

gcloud auth list

gcloud config list project

export GOOGLE_CLOUD_PROJECT=$(gcloud config get-value core/project)

gcloud iam service-accounts create my-natlang-sa \
--display-name "my natural language service account"

gcloud iam service-accounts keys create ~/key.json \
--iam-account my-natlang-sa@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com


gcloud compute ssh linux-instance --zone=$ZONE --quiet --command="gcloud ml language analyze-entities --content=\"Michelangelo Caravaggio, Italian painter, is known for 'The Calling of Saint Matthew'.\" > result.json"


