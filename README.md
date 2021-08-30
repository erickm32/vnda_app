# README

* Ruby version
  - 2.7.4

* Rails version
  - 6.1.4

Acho que nenhuma instrução diferenciada é necessária para rodar, fora o padrãozinho pro banco (`db:create db:migrate (ou schema load)`), mas ainda não tem nenhum seeds.rb de verdade no projeto.

Dá pra rodar `bundle exec rspec` e `bundle exec rubocop`. Porém, acabei não tendo tempo mais tempo aqui em casa para fazer testes adequadamente e mostrar o funcionamento sem precisar realmente subir um servidor.

Se tiver mais tempo durante a semana e for do interesse, posso voltar a mexer nisso.

De qualquer forma, mandei também um "server" sinatra pra replicar as respostas de exemplo da descrição do teste, que foi o que eu utilizei enquanto programava.
Só rodar um `gem install sinatra` e depois um `ruby lib/myapp.rb`, se quiser usar o mesmo.