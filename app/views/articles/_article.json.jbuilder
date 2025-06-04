json.extract!(article, :id, :name)

json.sgid(article.attachable_sgid)
json.content(render(partial: "articles/article", locals: {article: article}, formats: [:html]))
