devtools::check_rhub(email="Matthieu.Stigler@gmail.com", interactive=FALSE)

devtools::check_win_devel()
devtools::check_win_release()
devtools::check_win_oldrelease()

devtools::build()
usethis::use_gpl_license(version = 3, include_future = TRUE)

## then
# direct: devtools::submit_cran()

curl::curl_fetch_memory("ftp://win-builder.r-project.org")
