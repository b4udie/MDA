# MovieDatabaseAPI

## Architecture 
I have chosen VIPER architecture without `R`, but with `C`, where C - Coordinator, to give more control in navigation flow and data transactions between different modules. 
VIPER has proven to be a sustainable, scalable, and well-known architecture, which gives us stability and a low entry threshold for new developers. 
If Interactor just proxies and doesn't do any usable actions. For example, in cases when we have a lightweight module. We can throw out the `I`, and it will be similar to MVP architecture.

#### 3rd party libraries

- Moya
> It allows us not to write a lot of unnecessary code, which then needs to be maintained, tested, and so on.
Instead, we can easily create api requests using enums which conforms `TargetType`.
Already has useful plugins: AccessTokenPlugin, NetworkActivityPlugin, etc. 
It has the `RequestInterceptor` protocol which helps us to create an entity that will be responsible for request retrying.
- Swinject
> It`s lightweight dependency injection framework. 
Helps us in testing, rebuilding and initializing complex components
- Kinfisher
> It`s a powerful, pure-Swift library for downloading and caching images, which provides a clear and simple interface
