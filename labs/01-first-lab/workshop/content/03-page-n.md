**_This is an example from BRASB that shows various styles and formatting._**

---

1. Update the Controller.

   Let's update our `CashCardController` so it’s configured to listen for and handle HTTP requests to `/cashcards`.

   ```java
   @RestController
   @RequestMapping("/cashcards")
   public class CashCardController {

     @GetMapping("/{requestedId}")
     public ResponseEntity<String> findById() {
       return ResponseEntity.ok("{}");
     }
   }

   ```

2. Understand the Spring Web annotations.

   Let's review our additions.

   - ```java
      @RestController
     ```

     This tells Spring that this class is a `Component` of type `RestController` and capable of handling HTTP requests.

   - ```java
      @RequestMapping("/cashcards")
     ```

     This is a companion to `@RestController` that indicates which address requests must have to access this Controller.

   - ```java
      @GetMapping("/{requestedId}")
      public ResponseEntity<String> findById() {...}
     ```

   `@GetMapping` marks a method as a _handler method._ `GET` requests that match `cashcards/{requestedID}` will be handled by this method.

3. Run the tests.

   They now pass!

   `BUILD SUCCESSFUL in 6s`

Now we have a Controller and handler method that matches the request performed in our test.
