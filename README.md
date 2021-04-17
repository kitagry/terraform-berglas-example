## terraform-berglas-example

### Usage

1. install [berglas](https://github.com/GoogleCloudPlatform/berglas)

2. Setup berglas

```sh
gcloud auth application-default login

gcloud services enable --project ${PROJECT_ID} \
  cloudkms.googleapis.com \
  storage-api.googleapis.com \
  storage-component.googleapis.com

berglas bootstrap --project $PROJECT_ID --bucket $BUCKET_ID
```

3. Install berglas provider for terraform

```sh
./install_berglass_provider.sh
```

4. Use terrafrom

```
# This create Cloud SQL
terraform apply

# Enter PROJECT_ID and BUCKET_ID
```

5. Check secret info

```
$ berglas list $BUCKET_ID
DB_USER
DB_PASS

$ berglas access DB_PASS
```
