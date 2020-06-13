all: update_theme clone_site compile deploy

.PHONY: all

NOW = $(shell date)
GITHUB_ACTOR = Ian Rodrigues
GITHUB_EMAIL = ianrdgs@gmail.com
GITHUB_PAGES_REPO = git@github.com:ianrodrigues/ianrodrigues.github.io.git

update_theme:
	@printf "\033[0;32mUpdating theme submodule...\033[0m\n"
	git submodule foreach git pull origin master

clone_site:
	@printf "\033[0;32mCloning site from remote...\033[0m\n"
	rm -rf public
	git clone $(GITHUB_PAGES_REPO) public

compile:
	@printf "\033[0;32mCompiling content...\033[0m\n"
	hugo -t amperage --minify --gc

deploy:
	@printf "\033[0;32mDeploying content to GitHub...\033[0m\n"
	cd public && \
		git add --all && \
		git commit -m "auto-release: build on $(NOW)" && \
		git push origin master
