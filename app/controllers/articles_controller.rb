class ArticlesController < ApplicationController

  before_filter :find_article,      only: [:show, :edit, :update, :destroy]
  # Метод find_article будет вызван перед указанными экшнами.
  http_basic_authenticate_with name: "dev", password: "123", except: [:index, :show]

  def index # Показывает страницу со списком статей.
    @articles = Article.all
  end

  # /articles/1 GET
  def show  # Показывает конкретную статью из базы данных.
    unless @article
      render_404
    end
  end

  # /articles/new GET
  def new # Рендерит форму для создания статьи.
    @article = Article.new
  end

  # /articles/1/edit GET
  def edit  # Рендерит форму для существуюшей статьи.
  end

  # /articles POST
  def create  # Создаёт новую запись в базе данных. Обрабатывает запрос,
    # приходящий из формы создания статьи (def new).
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'  # Рендер используется в случае ошибки для повторного вывода
      # формы.
    end
  end

  # /articles/1 PUT
  def update  # Находит существующую запись в базе данных и обновляет её.
    @article.update_attributes(article_params)
    if @article.errors.empty?
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end

  # /articles/1 DELETE
  def destroy # Находит существующую запись в базе данных и удалает её.
    @article.destroy
    redirect_to action: "index"
  end

  private # Приватные методы не являются экшенами.

  def find_article   # Этот метод не экшен, а before_filter.
    @article = Article.friendly.find(params[:id])  # Переменные экземпляра автоматом доступны
    # в шаблонах.
    unless @article
      render_404
    end
  end

  def article_params
    params.require(:article).permit!  # Установит все параметры из схемы данных.
    # Неуказанные параметры не сохранятся в базе.
  end

end
