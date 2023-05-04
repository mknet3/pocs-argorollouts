help: ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)
k8s-start: ## Start minikube and docker-mac-net-connect.
	sudo brew services start chipmk/tap/docker-mac-net-connect
	minikube start
k8s-stop: ## Stop minikube and docker-mac-net-connect.
	sudo brew services stop chipmk/tap/docker-mac-net-connect
	minikube stop
tf-plan: ## Execute terraform plan.
	terraform -chdir=infrastructure plan
tf-apply: ## Execute terraform apply.
	terraform -chdir=infrastructure apply -auto-approve
tf-destroy: ## Execute terraform destroy.
	terraform -chdir=infrastructure destroy -auto-approve