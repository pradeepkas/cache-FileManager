# NSCache and FileManager usage or manger

## [NSCache](https://github.com/pradeepkas/cache-FileManager/blob/main/LocalCacheExample/cache/CacheManager.swift)

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
```
```swift
getter
let data = cacheManager.object(forKey: key as NSString)

```

## [File Manager](https://github.com/pradeepkas/cache-FileManager/blob/main/LocalCacheExample/cache/FileManager.swift)

Its management same as we do in our local file system

1. first we have to create folder if we want
2. then in this folder will store data 


```swift
if !FileManager.default.fileExists(atPath: folderpath.absoluteString) { // 1
        do {
                try FileManager.default.createDirectory(at: folderpath, withIntermediateDirectories: true) //2 
        }catch let error {
                print(error.localizedDescription)
        }
}
```

code snippet : 
1. we are checking requied path already exist or not 
2. if not then will create directory like folder 


## setter

```swift
do {
   try data.write(to: folderPath)
} catch let error {
  print("error \(error.localizedDescription)")
}
```

## getter 

```swift
UIImage(contentsOfFile: folderPath.path)
```


### Hope this will help in your local management !!

Happy coding!! 