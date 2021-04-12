# Common Questions 



## Raspbian Buster Linking Error

**Description:** This linking error occurs when installing `ros2/rcl`,  `ros/rclcpp`, `tlsf`, `tlsf_cpp` packages. The issues is Pi cannot link to `automic` library.

**Solution:** Modify the corresponding `CMakeLists.txt` in `rcl` packages by following the git:

- [Linking error on Raspbian Buster #550](https://github.com/ros2/rcl/issues/550)

The solution is to add `add_link_options(-latomic)` to the corresponding `CMakeLists.txt`.

**Note:** There is also a similar issue when installing `rcutils` package: [Linking error (test_atomics_executable) on Raspbian/armv6l #171](https://github.com/ros2/rcutils/issues/171). The idea to solve the issue is similar. But the modified code is not the same.

