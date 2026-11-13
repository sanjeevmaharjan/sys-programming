#include <cstdio>
#include <string>

#include <gtest/gtest.h>

TEST(SysProgramming, PrintsReadyMessageAndExitsSuccessfully)
{
    FILE *program = popen("./build/sys_programming", "r");
    ASSERT_NE(program, nullptr);

    char buffer[128];
    std::string output;
    while (fgets(buffer, sizeof(buffer), program) != nullptr)
        output += buffer;

    const int status = pclose(program);
    ASSERT_EQ(status, 0);
    EXPECT_EQ(output, "System programming project is ready.\n");
}
