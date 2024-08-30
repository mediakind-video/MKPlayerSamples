pluginManagement {
    repositories {
        google {
            content {
                includeGroupByRegex("com\\.android.*")
                includeGroupByRegex("com\\.google.*")
                includeGroupByRegex("androidx.*")
            }
        }
        mavenCentral()
        gradlePluginPortal()
        mavenLocal()
        maven {
            url = uri("https://mkplayer.jfrog.io/artifactory/mkplayer/")
        }
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
        mavenLocal()
        maven {
            url = uri("https://mkplayer.jfrog.io/artifactory/mkplayer/")
        }
        maven {
            url = uri("https://artifacts.bitmovin.com/artifactory/public-releases")
        }
    }
}

rootProject.name = "MultiVideo Reference MK App"
include(":app")
 