The `clear_backend` folder follows the Clear Architecture design pattern. It contains the backend code for the TransitTrack project. This folder is organized in a way that promotes separation of concerns and maintainability. It includes different subfolders for different components of the backend, such as controllers, models, services, and repositories. Each component has its own responsibility and can be easily modified or replaced without affecting other parts of the system. This folder structure helps to keep the codebase clean and scalable.

- **app/**: The main application directory.
  - **api/**: Contains the API routes and endpoints.

  - **core/**: Contains core configurations and settings.

  - **models/**: Contains the data models.

  - **repositories/**: Contains the repository classes for data access.

  - **schemas/**: Contains the Pydantic models for request and response validation.

   - **services/**: Contains the business logic of the application.

- **tests/**: Contains the test cases for the application.
- **requirements.txt**: List of dependencies for the project.


### Getting started, 
1. ** Clone the repository**
    ```sh
    git clone <repo-url>
    cd project 
     ```
2. **install dependencies**
```sh
pip install -r requirements.txt
 ```

3. **set up environment variable**
```sh
MONGODB_URL=mongodb://localhost:27017
```

4. **run the application**
```sh
uvicorn app.main:app --reload

```