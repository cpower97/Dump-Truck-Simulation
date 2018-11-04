r1 = 1 #Set number of sweeps required
end = 1000 #Number of time units required for each simulation

#Initialise the system state variables

LQt = 0
Lt = 0
WQt = 0
Wt = 0

#Create functions for distributions of activities

LoadingTime = function(rand) { #Time taken to load truck
  if (rand < 0.3) {
    result = 5
  }
  else if (rand < 0.8){
    result = 10
  }
  else {
    result = 15
  }
}

WeighingTime = function(rand) { #Time taken to weigh truck
  if (rand < 0.7) {
    result = 12
  }
  else {
    result = 16
  }
}

TravelTime = function(rand) { #Time taken to travel from Scale to Loader Queue
  if (rand < 0.4) {
    result = 40
  }
  else if (rand < 0.7) {
    result = 60
  }
  else if (rand < 0.9) {
    result = 80
  }
  else {
    result = 100
  }
}

#Variables to keep track of 

CompD = 0 #No of completed deliveries
LoadT = 0 #Total time spent loading, if both in use double time
WeighT = 0 #Total time spent weighing 

FEL = data.frame(times = c(LoadingTime(runif(1, 0, 1)),WeighingTime(runif(1, 0, 1)),TravelTime(runif(1, 0, 1)), end), event=c("LoadTime", "Weigh", "Travel", "End"))
#Times for loading to take place, weighing to take place, arrival at loading to take place and end

event = "Load Time" #Initialise with truck finishing at loading
while (event != "End") { #Continue process until end event
  
  FEL = FEL[order(FEL[,1]),] # Order the Future Event List so successive events appear as successive rows.
  t = FEL[1,1] #Update clock to new time of next event
  event = FEL[1,2] #Record event type
  FEL[1,] = NA #Remove current event from FEL
  
  if (event == "Weigh") { #Logic if next event is truck is finished weighing
    print(c("Truck finished weighing at ", t))
    WeighT = WeighT + t #Update total weighing time
    
    if ((Lt == 0) || (Lt == 1)) {
      Lt = Lt + 1
      NewLoadDepEvent = data.frame(times=c(time+ LoadingTime(runif(1,0,1))),event = c('LoadTime'))
      #Create new loading time event because of new truck being loaded.
      FEL = rbind(FEL, Loa)
    }
  }
}