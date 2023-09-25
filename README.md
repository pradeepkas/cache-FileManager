# NSCache and FileManager usage or manger

In this major thing still we are usign objective C comptiable objects like `NSString` in place of `String`

let suppose we have to store images then simply we can create object like this 
1. define type 
2. set count limit means number objects you want store in this cache
3. set limit according to requiement

```swift
private var cacheManager: NSCache<NSString, UIImage>  {
     let manager = NSCache<NSString, UIImage>()
     manager.countLimit = 300
     manager.totalCostLimit = 500 * 1024 * 1024 
        //500 MB
    return manager
}
```

## Setter and Getter method

simple and same as other like user default : 


```swift
setter
cacheManager.setObject(image, forKey: key as NSString)

getter
let data = cacheManager.object(forKey: key as NSString)

```

