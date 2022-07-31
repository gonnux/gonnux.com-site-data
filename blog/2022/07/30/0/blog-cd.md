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

뭐어쨌든 결국은 gonnux.com-site 와 gonnux.com-site-data로 레포 분리

전자는 순수한 nextjs 코드만

후자는 블로그 포스트들, config.yaml, Dockerfile, 도커 이미지 빌드를 위한git workflow file이 있다

여기까지해서 이미지 자동 빌드 및 docker hub 업로드는 성공

이제 docker hub에 업로드 되는 최신 이미지를 k8s 클러스터에서 deployment를 업데이트 해줘야함

생각해본 방법들

git workflow 에서 ssh 접속후 kubectl 로 직접 배포 -> 보안상으로 매우 부적절한 방법인듯

jenkins -> 한국어로 검색하면 jenkins를 많이 이용하는 것을 알 수 있다.
다만 대부분 docker image 빌드부터 deployment 배포까지 jenkins에서 해결하고 있다
docker registry를 체크하고 deployment만 배포하는데 jenkins는 너무 과한거 아닌가 생각중

argocd -> argocd는 기본적으로 k8s yml 파일의 변경만을 감지하는 것 같다.. 따라서 이번 목적이랑 잘 안맞는것 같은데 확실하지 않음

gitkube

webhook: docker hub에서 webhook을 설정하고
https://github.com/adnanh/webhook 등을 이용하여 webhook 요청을 받아 kubectl 커맨드 실행하여 재배포

tekton?
keel.sh poll 방식과 webhook 방식 지원, docker image 변경시 자동 배포에 초첨이 맞춰져있다


## References
- https://www.suse.com/c/rancher_blog/continuous-delivery-pipeline-with-webhooks/
- https://keel.sh/docs/
