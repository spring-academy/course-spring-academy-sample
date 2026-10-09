**_This is an example from BRASB that shows various styles and formatting._**

---

Just as if we’re on a real project, let’s use test driven development begin our hands-on learning journey in this project.

1. Envision the simplest architecture you can. Make a picture. Here's a nefarious example: _(note to reader: This is how we do images in labs - not articles. See the sample article for how that is done.)_

![Maybe not the simplest architecture](https://raw.githubusercontent.com/spring-academy/spring-academy-assets/main/courses/spring-academy-sample-course/complicated-architecture.jpg)

2. Write the test.

   Let's start by implementing a test using Spring's `@SpringBootTest`.

   Update `src/test/java/example/cashcard/CashCardApplicationTests.java` with the following:

   ```java
   package example.cashcard;

   import static org.assertj.core.api.Assertions.assertThat;

   import com.jayway.jsonpath.DocumentContext;
   import com.jayway.jsonpath.JsonPath;
   import org.junit.jupiter.api.Test;
   import org.springframework.beans.factory.annotation.Autowired;
   import org.springframework.boot.test.context.SpringBootTest;
   import org.springframework.boot.test.web.client.TestRestTemplate;
   import org.springframework.http.HttpStatus;
   import org.springframework.http.ResponseEntity;

   @SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
   class CashCardApplicationTests {

     @Autowired
     TestRestTemplate restTemplate;

     @Test
     void shouldReturnACashCardWhenDataIsSaved() {
       ResponseEntity<String> response = restTemplate.getForEntity(
         "/cashcards/99",
         String.class
       );

       assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
     }
   }

   ```

3. Understand the test.

   Let's understand several important elements in this test.

   - ```java
     @SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
     ```

     This will start our Spring Boot application and make it available for our test to perform requests to it.

   - ```java
     @Autowired
     TestRestTemplate restTemplate;

     ```

     We've asked Spring to inject a test helper that’ll allow us to make HTTP requests to the locally running application.

     **_Note_** that while `@Autowired` is a form of Spring dependency injection it’s best used only in tests. We'll discuss this in more detail later.

   - ```java
     ResponseEntity<String> response = restTemplate.getForEntity(
       "/cashcards/99",
       String.class
     );

     ```

     Here we use `restTemplate` to make an HTTP `GET` request to our application endpoint `/cashcards/99`.

     `restTemplate` will return a `ResponseEntity`, which we've captured in a variable we've named `response`. `ResponseEntity` is another helpful Spring object that provides valuable information about what happened with our request. We will use this information throughout out tests in this course.

   - ```java
     assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
     ```

     We can inspect many aspects of the `response`, including the HTTP Response Status code, which we expect to be `200 OK`.

4. Now run the test.

   What do you think will happen when we run the test?

   It will fail, _as expected_. Why? As we’ve learned in test-first practice, we describe our expectations _before_ we implement the code that satisfies those expectations.

   Now let’s run the test. Note that we will run `./gradlew test` for every test run.

   ```bash
   [~/exercises] $ ./gradlew test
   ```

   It fails! Search the output for the following:

   ```log
   CashCardApplicationTests > shouldReturnACashCardWhenDataIsSaved() FAILED
     org.opentest4j.AssertionFailedError:
     expected: 200 OK
      but was: 404 NOT_FOUND
   ```

   But why are we getting this specific failure?

5. Understand the test failure.

   As we explained, we expected our test to currently fail.

   Why is it failing due to an unexpected `404 NOT_FOUND` HTTP response code?

   Answer: since we have not instructed Spring Web how to handle `GET cashcards/99`, Spring Web is automatically responding that the endpoint is `NOT_FOUND`.

   Thank you for handling that for us, Spring Web!

Next, let's get our application working properly.
