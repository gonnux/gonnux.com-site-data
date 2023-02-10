# 스프링 부트 기반 라이브러리에서의 통합 테스트(작성중)
## 라이브러리에서의 @SpringBootTest 
라이브러리는 기본적으로 @SpringBootApplication가 붙은 클래스가 없다<br/>
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
	at org.springframework.util.Assert.state(Assert.java:76)
	at org.springframework.boot.test.context.SpringBootTestContextBootstrapper.getOrFindConfigurationClasses(SpringBootTestContextBootstrapper.java:236)
	at org.springframework.boot.test.context.SpringBootTestContextBootstrapper.processMergedContextConfiguration(SpringBootTestContextBootstrapper.java:152)
	at org.springframework.test.context.support.AbstractTestContextBootstrapper.buildMergedContextConfiguration(AbstractTestContextBootstrapper.java:393)
	at org.springframework.test.context.support.AbstractTestContextBootstrapper.buildDefaultMergedContextConfiguration(AbstractTestContextBootstrapper.java:309)
	at org.springframework.test.context.support.AbstractTestContextBootstrapper.buildMergedContextConfiguration(AbstractTestContextBootstrapper.java:262)
	at org.springframework.test.context.support.AbstractTestContextBootstrapper.buildTestContext(AbstractTestContextBootstrapper.java:107)
	at org.springframework.boot.test.context.SpringBootTestContextBootstrapper.buildTestContext(SpringBootTestContextBootstrapper.java:102)
	at org.springframework.test.context.TestContextManager.<init>(TestContextManager.java:137)
	at org.springframework.test.context.TestContextManager.<init>(TestContextManager.java:122)
	at org.junit.jupiter.engine.execution.ExtensionValuesStore.lambda$getOrComputeIfAbsent$4(ExtensionValuesStore.java:86)
	at org.junit.jupiter.engine.execution.ExtensionValuesStore$MemoizingSupplier.computeValue(ExtensionValuesStore.java:223)
	at org.junit.jupiter.engine.execution.ExtensionValuesStore$MemoizingSupplier.get(ExtensionValuesStore.java:211)
	at org.junit.jupiter.engine.execution.ExtensionValuesStore$StoredValue.evaluate(ExtensionValuesStore.java:191)
	at org.junit.jupiter.engine.execution.ExtensionValuesStore$StoredValue.access$100(ExtensionValuesStore.java:171)
	at org.junit.jupiter.engine.execution.ExtensionValuesStore.getOrComputeIfAbsent(ExtensionValuesStore.java:89)
	at org.junit.jupiter.engine.execution.ExtensionValuesStore.getOrComputeIfAbsent(ExtensionValuesStore.java:93)
	at org.junit.jupiter.engine.execution.NamespaceAwareStore.getOrComputeIfAbsent(NamespaceAwareStore.java:61)
	at org.springframework.test.context.junit.jupiter.SpringExtension.getTestContextManager(SpringExtension.java:294)
	at org.springframework.test.context.junit.jupiter.SpringExtension.beforeAll(SpringExtension.java:113)
	at org.junit.jupiter.engine.descriptor.ClassBasedTestDescriptor.lambda$invokeBeforeAllCallbacks$10(ClassBasedTestDescriptor.java:381)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.jupiter.engine.descriptor.ClassBasedTestDescriptor.invokeBeforeAllCallbacks(ClassBasedTestDescriptor.java:381)
	at org.junit.jupiter.engine.descriptor.ClassBasedTestDescriptor.before(ClassBasedTestDescriptor.java:205)
	at org.junit.jupiter.engine.descriptor.ClassBasedTestDescriptor.before(ClassBasedTestDescriptor.java:80)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$6(NodeTestTask.java:148)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$8(NodeTestTask.java:141)
	at org.junit.platform.engine.support.hierarchical.Node.around(Node.java:137)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$9(NodeTestTask.java:139)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.executeRecursively(NodeTestTask.java:138)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.execute(NodeTestTask.java:95)
	at java.util.ArrayList.forEach(ArrayList.java:1259)
	at org.junit.platform.engine.support.hierarchical.SameThreadHierarchicalTestExecutorService.invokeAll(SameThreadHierarchicalTestExecutorService.java:41)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$6(NodeTestTask.java:155)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$8(NodeTestTask.java:141)
	at org.junit.platform.engine.support.hierarchical.Node.around(Node.java:137)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.lambda$executeRecursively$9(NodeTestTask.java:139)
	at org.junit.platform.engine.support.hierarchical.ThrowableCollector.execute(ThrowableCollector.java:73)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.executeRecursively(NodeTestTask.java:138)
	at org.junit.platform.engine.support.hierarchical.NodeTestTask.execute(NodeTestTask.java:95)
	at org.junit.platform.engine.support.hierarchical.SameThreadHierarchicalTestExecutorService.submit(SameThreadHierarchicalTestExecutorService.java:35)
	at org.junit.platform.engine.support.hierarchical.HierarchicalTestExecutor.execute(HierarchicalTestExecutor.java:57)
	at org.junit.platform.engine.support.hierarchical.HierarchicalTestEngine.execute(HierarchicalTestEngine.java:54)
	at org.junit.platform.launcher.core.EngineExecutionOrchestrator.execute(EngineExecutionOrchestrator.java:107)
	at org.junit.platform.launcher.core.EngineExecutionOrchestrator.execute(EngineExecutionOrchestrator.java:88)
	at org.junit.platform.launcher.core.EngineExecutionOrchestrator.lambda$execute$0(EngineExecutionOrchestrator.java:54)
	at org.junit.platform.launcher.core.EngineExecutionOrchestrator.withInterceptedStreams(EngineExecutionOrchestrator.java:67)
	at org.junit.platform.launcher.core.EngineExecutionOrchestrator.execute(EngineExecutionOrchestrator.java:52)
	at org.junit.platform.launcher.core.DefaultLauncher.execute(DefaultLauncher.java:114)
	at org.junit.platform.launcher.core.DefaultLauncher.execute(DefaultLauncher.java:86)
	at org.junit.platform.launcher.core.DefaultLauncherSession$DelegatingLauncher.execute(DefaultLauncherSession.java:86)
	at org.junit.platform.launcher.core.SessionPerRequestLauncher.execute(SessionPerRequestLauncher.java:53)
	at org.gradle.api.internal.tasks.testing.junitplatform.JUnitPlatformTestClassProcessor$CollectAllTestClassesExecutor.processAllTestClasses(JUnitPlatformTestClassProcessor.java:99)
	at org.gradle.api.internal.tasks.testing.junitplatform.JUnitPlatformTestClassProcessor$CollectAllTestClassesExecutor.access$000(JUnitPlatformTestClassProcessor.java:79)
	at org.gradle.api.internal.tasks.testing.junitplatform.JUnitPlatformTestClassProcessor.stop(JUnitPlatformTestClassProcessor.java:75)
	at org.gradle.api.internal.tasks.testing.SuiteTestClassProcessor.stop(SuiteTestClassProcessor.java:62)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.gradle.internal.dispatch.ReflectionDispatch.dispatch(ReflectionDispatch.java:36)
	at org.gradle.internal.dispatch.ReflectionDispatch.dispatch(ReflectionDispatch.java:24)
	at org.gradle.internal.dispatch.ContextClassLoaderDispatch.dispatch(ContextClassLoaderDispatch.java:33)
	at org.gradle.internal.dispatch.ProxyDispatchAdapter$DispatchingInvocationHandler.invoke(ProxyDispatchAdapter.java:94)
	at com.sun.proxy.$Proxy2.stop(Unknown Source)
	at org.gradle.api.internal.tasks.testing.worker.TestWorker$3.run(TestWorker.java:193)
	at org.gradle.api.internal.tasks.testing.worker.TestWorker.executeAndMaintainThreadName(TestWorker.java:129)
	at org.gradle.api.internal.tasks.testing.worker.TestWorker.execute(TestWorker.java:100)
	at org.gradle.api.internal.tasks.testing.worker.TestWorker.execute(TestWorker.java:60)
	at org.gradle.process.internal.worker.child.ActionExecutionWorker.execute(ActionExecutionWorker.java:56)
	at org.gradle.process.internal.worker.child.SystemApplicationClassLoaderWorker.call(SystemApplicationClassLoaderWorker.java:113)
	at org.gradle.process.internal.worker.child.SystemApplicationClassLoaderWorker.call(SystemApplicationClassLoaderWorker.java:65)
	at worker.org.gradle.process.internal.worker.GradleWorkerMain.run(GradleWorkerMain.java:69)
	at worker.org.gradle.process.internal.worker.GradleWorkerMain.main(GradleWorkerMain.java:74)

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
- @SpringBootTest(classes=...)가 명시되어 있지 않거나 nested @Configuration이 없는 경우 @SpringBootConfiguration을 찾는다

바로 이부분이 에러의 원인이다
해결책을 알기 앞서 @SpringBootTest에 대해 차근차근 이해해보자

## @ExtendWith(SpringExtension.class)

> @ExtendWith is a repeatable annotation that is used to register extensions for the annotated test class, test interface, test method, parameter, or field.  
> Annotated parameters are supported in test class constructors, in test methods, and in @BeforeAll, @AfterAll, @BeforeEach, and > @AfterEach lifecycle methods.
> @ExtendWith fields may be either static or non-static.
```java
	@Override
	public void beforeAll(ExtensionContext context) throws Exception {
		getTestContextManager(context).beforeTestClass();
	}

	/**
	 * Delegates to {@link TestContextManager#afterTestClass}.
	 */
	@Override
	public void afterAll(ExtensionContext context) throws Exception {
		try {
			getTestContextManager(context).afterTestClass();
		}
		finally {
			getStore(context).remove(context.getRequiredTestClass());
		}
	}

	/**
	 * Delegates to {@link TestContextManager#prepareTestInstance}.
	 * <p>As of Spring Framework 5.3.2, this method also validates that test
	 * methods and test lifecycle methods are not annotated with
	 * {@link Autowired @Autowired}.
	 */
	@Override
	public void postProcessTestInstance(Object testInstance, ExtensionContext context) throws Exception {
		validateAutowiredConfig(context);
		getTestContextManager(context).prepareTestInstance(testInstance);
	}
```

## @SpringBootTest(classes=...)와 @ContextConfiguration, 그리고 스캔 순서
@SpringBootTest(classes=...)는 @ContextConfiguration(classes=...)와 동일한 동작을 한다

> The component classes to use for loading an ApplicationContext. Can also be specified using @ContextConfiguration(classes=...). If no explicit classes are defined the test will look for nested @Configuration classes, before falling back to a @SpringBootConfiguration search.

ApplicationContext를 로딩할 때 사용되는 컴포넌트(빈)들의 클래스들을 명시해줄 수 있다
classes가 정의되면 해당되는 클래스들만 로딩하고 그렇지 않으면 nested @Configuration, @SpringBootConfiguration 순으로 스캔한다

https://docs.spring.io/spring-boot/docs/2.1.5.RELEASE/reference/html/boot-features-testing.html
> If you are familiar with the Spring Test Framework, you may be used to using @ContextConfiguration(classes=…​) in order to specify which Spring @Configuration to load. Alternatively, you might have often used nested @Configuration classes within your test.  
> When testing Spring Boot applications, this is often not required. Spring Boot’s @*Test annotations search for your primary configuration automatically whenever you do not explicitly define one.  
> The search algorithm works up from the package that contains the test until it finds a class annotated with @SpringBootApplication or @SpringBootConfiguration. As long as you structured your code in a sensible way, your main configuration is usually found.
 
요약하자면
1. @SpringBootTest(classes=...)가 명시되어있는 경우 classes에 명시된 클래스의 컴포넌트들만 로딩
2. 명시되어있지 않으면 테스트 클래스의 패키지부터 @SpringBootConfiguration 이나 @SpringBootApplication (내부적으로 @SpringBootConfiguration 사용)을 찾을때까지 위로 올라가면서 스캔

앞에서 언급했던 exception이 최종적으로 발생하는 곳을 보면 (SpringBootTextContextBootstrapper) 다음과 같은데
```java
	protected Class<?>[] getOrFindConfigurationClasses(MergedContextConfiguration mergedConfig) {
		Class<?>[] classes = mergedConfig.getClasses();
		if (containsNonTestComponent(classes) || mergedConfig.hasLocations()) {
			return classes;
		}
		Class<?> found = new AnnotatedClassFinder(SpringBootConfiguration.class)
				.findFromClass(mergedConfig.getTestClass());
		Assert.state(found != null, "Unable to find a @SpringBootConfiguration, you need to use "
				+ "@ContextConfiguration or @SpringBootTest(classes=...) with your test");
		logger.info("Found @SpringBootConfiguration " + found.getName() + " for test " + mergedConfig.getTestClass());
		return merge(found, classes);
	}
```
SpringBootConfiguration을 찾으려고 하는 것을 알수 있다.

## 해결책
결국 해결책은
- @SpringBootTest(classes=...)를 명시하거나
- test 디렉토리에 SpringBootApplication 혹은 SpringBootConfiguration을 추가 (개인적으로 SpringBootApplication 보다는 SpringBootConfiguration가 더 적절하다고 생각)

main도 가능하긴 하지만 현재 프로젝트가 라이브러리인이상 적절하지 않은 방법이다

## 검증
### 테스트 코드
```kotlin
class DemoApplicationTests(
    private val ctx: ApplicationContext
) {

    @Test
    fun contextLoads() {
        println("---------------------------")
        ctx.getBeanDefinitionNames().forEach {
            println(it)
        }
        println("---------------------------")
    }

}
```
```kotlin
@Configuration
class MyConfig {
    @Bean
    fun myBean(): MyBean {
        return MyBean()
    }
}
```
```kotlin
@TestConfiguration
class MyTestConfig {
    @Bean
    fun myBean(): MyBean {
        return MyBean()
    }
}
```

### @SpringBootTest(classes = [MyConfig::class])
```kotlin
@SpringBootTest(classes = [MyConfig::class])
```

### @SpringBootTest(classes = [MyTestConfig::class])
```kotlin
@SpringBootTest(classes = [MyTestConfig::class])
```

이 경우에는 바로 이렇게 사용하면 에러가 난다
> Unlike regular @Configuration classes the use of @TestConfiguration does not prevent auto-detection of @SpringBootConfiguration

@TestConfiguration의 경우에는 여전히 @SpringBootConfiguration이 존재해야한다

### @SpringBootTest, @SpringBootApplication
```kotlin
@SpringBootApplication
class DemoApplication

fun main(args: Array<String>) {
    runApplication<DemoApplication>(*args)
}
```

### @SpringBootTest, @SpringBootConfiguration
```kotlin
@SpringBootConfiguration
class DemoConfiguration
```

## ComponentScan
```kotlin
@ComponentScan(basePackages = ["com.example.demo"])
@TestConfiguration
class MyTestConfig() {
    @Bean
    fun myBean(): MyBean {
        return MyBean()
    }
}
```
이 경우에는 같은 빈을 생성하는 Configuration이 존재하면 에러가 난다
spring.main.allow-bean-definition-overriding=true 를 설정해야한다
```console
   ***************************                                                                                         
    APPLICATION FAILED TO START                                                                                         
    ***************************                                                                                         
                                                                                                                        
    Description:                                                                                                        
                                                                                                                        
    The bean 'myBean', defined in com.example.demo.MyTestConfig, could not be registered. A bean with that name has alre
ady been defined in class path resource [com/example/demo/MyConfig.class] and overriding is disabled.                   
                                                                                                                        
    Action:                                                                                                             
                                                                                                                        
    Consider renaming one of the beans or enabling overriding by setting spring.main.allow-bean-definition-overriding=tr
ue
```
