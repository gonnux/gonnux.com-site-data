## Goal & Problems
- When pushing to the blog repo, the docker image should be built automatically
- When pushing to the blog repo, the k8s deployment should be updated automatically
## Build
- There are two repos: gonnux/gonnux.com-blog and gonnux/gonnux.com-site
- First one is a collection of blog post markdown files.
- Second one is NextJS project and this is built statically from markdown files from first repo.

blog 레포 에서 site 레포를 submodule로 사용하고 docker image 도 이쪽에서만 빌드한다면?
blog 레포는 더이상 블로그 포스트로써만 사용하는 것이 아니라 site레포가 필요로 하는 데이터를 제공하도록 한다면?
gonnux.com-site 레포(nextjs app)는 도커 이미지로 사용하기에 부적합하다고 판단
