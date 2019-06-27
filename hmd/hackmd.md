<!-- .slide: data-background="#7fcdbb" -->

Social benefits of slow food
===
Group 4 Project

Katarina, Kirana, Adrien, Cyril, Thibaud


![slowfood](https://static1.squarespace.com/static/58990bc51e5b6cdf8308ce9e/t/58b63556d2b857a4ad9896db/1488336215805/?format=750w)

---

## Plan
<!-- .slide: data-background="#7fcdbb" -->


---

## Modified code

~~~~scala
val hRs1 = Val[Double]
val hIp1 = Val[Double]
val hRs2 = Val[Double]
val hIp2 = Val[Double]

val seed = Val[Long]

val rescuedDynamic = Val[Array[Int]]
val zombifiedDynamic = Val[Array[Int]]
val rescuedDynamicSlow = Val[Array[Int]]
val rescuedDynamicFast = Val[Array[Int]]

val nbSlow = Val[Int]

val model =
  ScalaTask("""
    import zombies._

    val agents =
      (0 until nbSlow).map(_ => Human(informProbability = hIp1, runSpeed=hRs1, informed=true))


    val rng = Random(seed)

    val result = zombieInvasion(
      humanInformProbability = hIp2,
      humanRunSpeed=hRs2,
      zombies = 4,
      humans = 250 - nbSlow,
      agents = agents,
      steps = 500,
      random = rng,
      humanInformedRatio=0.0)

    val rescuedDynamic = result.rescuedDynamic()
    val zombifiedDynamic = result.zombifiedDynamic()
    val rescuedDynamicSlow = result.filteredRescuedDynamic(runSpeed = Some(_ <= 0.3))
    val rescuedDynamicFast = result.filteredRescuedDynamic(runSpeed = Some(_ > 0.3))
  """) set (
    hIp1 := 0.8,
    hRs1 := 0.3,
    hIp2 := 0.09,
    hRs2 := 0.49,
    nbSlow := 50,

    inputs += (seed, hRs1, hIp1, hRs2, hIp2, nbSlow),
    outputs += (rescuedDynamic, zombifiedDynamic, rescuedDynamicSlow, rescuedDynamicFast),
    plugins += pluginsOf[zombies.agent.Agent]
  )

// Define the execution environment
val env = SLURMEnvironment("xmodel04", "myria.criann.fr", queue = "2tcourt", wallTime = 20 minutes, nTasks = 1, memory = 2500, workDirectory = "/tmp", reservation = "exModelo0624")

/*def median(x: Array[Arrray[Double]]): Array[Double] = {
    x.transpose.map{_.median}
}*/

val exploration =
  Replication(
    evaluation = model on env hook display,
    seed = seed,
    replications = 1
    //agg = (rescuedDynamic aggregate median)
  )

exploration
~~~~
