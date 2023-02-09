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
이 현상을 이해하기 위해서는 @SpringBootTest에 대한 이해가 필요하다

> @Target(TYPE)  
> @Retention(RUNTIME)  
> @Documented  
> @Inherited  
> @BootstrapWith(SpringBootTestContextBootstrapper.class)  
> @ExtendWith(org.springframework.test.context.junit.jupiter.SpringExtension.class)  
> public @interface SpringBootTest  
> Annotation that can be specified on a test class that runs Spring Boot based tests. Provides the following features over and above the regular Spring TestContext Framework:  
> Uses SpringBootContextLoader as the default ContextLoader when no specific @ContextConfiguration(loader=...) is defined.  
> Automatically searches for a @SpringBootConfiguration when nested @Configuration is not used, and no explicit classes are specified.  
> Allows custom Environment properties to be defined using the properties attribute.  
> Allows application arguments to be defined using the args attribute.  
> Provides support for different webEnvironment modes, including the ability to start a fully running web server listening on a defined or random port.  
> Registers a TestRestTemplate and/or WebTestClient bean for use in web tests that are using a fully running web server.

여기서 중요한 부분은
- @ContextConfiguration(loader=...)가 명시되어있지 않은 경우 SpringBootContextLoader를 사용한다
- @SpringBootTest(classes=...)가 명시되어 있지 않거나 nested @Configuration이 없는 경우 @SpringBootConfiguration을 찾는다
