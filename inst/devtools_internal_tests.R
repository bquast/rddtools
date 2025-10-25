devtools::check_rhub(email="Matthieu.Stigler@gmail.com", interactive=FALSE)

devtools::check_win_devel()
devtools::check_win_release()
devtools::check_win_oldrelease()

devtools::build()


## then
# direct: devtools::submit_cran()

curl::curl_fetch_memory("ftp://win-builder.r-project.org")
