This folder `old-implementation` contains the pipelines used when the feature `Protect access to repositories in YAML pipelines` was enabled. An issue was experimented 5th Abril 2023, and the pipeline can not clone
the Azure Git Repositories out of his own repository, even having the repositories explicitly defined in the pipeline.

As a workaround/solution, `Protect access to repositories in YAML pipelines` was disabled and the pipeline can access every repository without the explicit definition in the pipeline.