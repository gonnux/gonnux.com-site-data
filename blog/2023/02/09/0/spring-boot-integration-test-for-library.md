# 스프링 부트 기반 라이브러리에서의 통합 테스트(작성중)
## @SpringBootTest
라이브러리는 기본적으로 @SpringBootApplication가 붙은 클래스가 없다
그 상태에서 통합테스트를 작성 시 에러가 발생한다
```kotlin
@SpringBootTest
internal class SimpleTests() {

    @Test
    fun test() {
    }
}
```
```console
Unable to find a @SpringBootConfiguration, you need to use @ContextConfiguration or @SpringBootTest(classes=...) with your test
java.lang.IllegalStateException: Unable to find a @SpringBootConfiguration, you need to use @ContextConfiguration or @SpringBootTest(classes=...) with your test
```
