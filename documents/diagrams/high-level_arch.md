<!--https://openclassrooms.com/en/courses/6397806-design-your-software-architecture-using-industry-standard-patterns/6896156-client-server-architecture -->

```mermaid
flowchart TD
  Server[Game server] <--> FE["Flutter Boggle game<br>(front end)"]
  FE <--> P1[Player 1]
  FE <--> P2[Player 2]
  FE <--> P3[Player 3]
  FE <--> P4[Player 4]
```