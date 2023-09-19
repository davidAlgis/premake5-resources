# Premake module for visual studio resources

This repository contains a simple module to add to your project the following lines:

```
<ItemGroup>
  <ResourceCompile Include="[NameProject].rc"/>
</ItemGroup>
```

The plugin add the macro `AddResource` which is a string that can be set to `"On"` or `"Off"`, the default value is `"Off"`. In each of the projects where you want to add the lines above, add the macro to `"On"`. 

If the file `[NameProject].rc` does not exist, it'll do nothing.