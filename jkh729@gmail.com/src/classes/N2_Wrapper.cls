public with sharing class N2_Wrapper {
	public N2_Wrapper() {
		
	}

	// Rank, Amount 정보 Insert를 위한 변수.
	public DevelopReview__c DevelopReviewEdit{
		get{
			if(DevelopReviewEdit==null) DevelopReviewEdit = new DevelopReview__c();
			return DevelopReviewEdit;
		}
		set;
	}

	public Map<String, Decimal> mapTotalAmount{
		get{
			if(mapTotalAmount==null){
				mapTotalAmount = new Map<String, Decimal>();

				Decimal totalAmount = 0;
				Decimal totalAverage = 0;

				for(wrapperRank w : mapWrapperRank.values()){
					totalAmount += w.totalAmount;
					totalAverage += w.totalAverage;
				}

				mapTotalAmount.put('totalAmount', totalAmount);
				mapTotalAmount.put('totalAverage', totalAverage);
			}
			return mapTotalAmount;
		}
		set;
	}

	public Map<String, wrapperRank> mapWrapperRank{
		get{
			if(mapWrapperRank==null){
				String query = 'SELECT Rank1__c, Rank2__c, Rank3__c, SUM(Amount__c) sumAmount, AVG(Probability__c) avgProbability';
				query += ' FROM DevelopReview__c';
				query += ' GROUP BY Rank1__c, Rank2__c, Rank3__c';
				query += ' ORDER BY Rank1__c, Rank2__c, Rank3__c';

				List<AggregateResult> resultList = Database.query(query);

				if(!resultList.isEmpty()){
					mapWrapperRank = new Map<String, wrapperRank>();
					for(AggregateResult ar : resultList){
						Decimal amount = (Decimal)ar.get('sumAmount');
						Decimal probability = (Decimal)ar.get('avgProbability');
						String rank1 = String.valueOf(ar.get('Rank1__c'));
						String rank2 = String.valueOf(ar.get('Rank2__c'));
						String rank3 = String.valueOf(ar.get('Rank3__c'));

						probability = (probability / 100).setScale(2);
						//system.debug('avgProbability : ' + avgProbability);

						// rank1 기준으로 집계.
						wrapperRank wrapper = mapWrapperRank.get(rank1);
						if(wrapper==null){
							wrapper = new wrapperRank(rank1);
							mapWrapperRank.put(rank1, wrapper);
						}

						if(wrapper.wrapperRankFirst==null){
							// 처음에는 Column을 잡아줘야 하기 때문에 첫번째 row의 값을 지정.
							wrapper.wrapperRankFirst = new wrapperRankFirst(rank1, rank2, rank3, amount, probability);
						}else{
							// rank2 기준으로 집계.
							wrapperRank subWrapper = wrapper.mapSubWrapperRank.get(rank2);
							if(subWrapper==null){
								subWrapper = new wrapperRank(rank2);
								wrapper.mapSubWrapperRank.put(rank2, subWrapper);
								wrapper.rowspanSize += 1; // sub total의 행추가.
							}

							if(subWrapper.wrapperRankFirst==null){
								// sub도 첫번째 row의 Column 값을 지정.
								subWrapper.wrapperRankFirst = new wrapperRankFirst(rank1, rank2, rank3, amount, probability);
							}else{
								subWrapper.listWrapperRanks.add(new wrapperRank(rank3, amount, probability));
								subWrapper.rowspanSize += 1;
								if(wrapper.wrapperRankFirst.rank2 == rank2) subWrapper.rowspanSize += 1;
							}

							system.debug('subWrapper.wrapperRankFirst.rank2 : ' + subWrapper.wrapperRankFirst.rank2);

							subWrapper.totalAmount += amount;
							subWrapper.totalAverage += amount * probability;
							wrapper.rowspanSize += 1; // sub가 추가될때마다, 행이 하나씩 추가.
						}
						wrapper.totalAmount += amount;
						wrapper.totalAverage += amount * probability;
					}	
				}

				system.debug('mapWrapperRank : ' + mapWrapperRank.values().size());
			}
			return mapWrapperRank;
		}
		set;
	}

	public void doSave(){
		savepoint sp = Database.setSavePoint();
		try{
			Insert DevelopReviewEdit;
			mapWrapperRank = null;
			mapTotalAmount = null;
		}catch(Exception e){
			Database.rollback(sp);
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
		}
	}

	// 처음에는 rank2의 합계를 먼저 구하고,
	// rank1의 합계를 구함.

	public class wrapperRank{
		public String rank {get; set;}
		public Decimal amount {get; set;}
		public Decimal probability {get; set;}
		public Decimal average {get; set;}

		public Decimal totalAmount {get; set;} // 각 Rank의 total
		public Decimal totalAverage {get; set;}
		public Integer rowspanSize {get; set;} // row span 사이즈.

		public wrapperRankFirst wrapperRankFirst {get; set;} // 첫번째 Row를 위한 변수.
		public Map<String, wrapperRank> mapSubWrapperRank {get; set;} // rank2를 key로 rank3을 묶기위한 map
		public List<wrapperRank> listWrapperRanks {get; set;} // rank3의 list
		
		public wrapperRank(String gRank){
			rank = gRank;
			totalAmount = 0;
			totalAverage = 0;
			rowspanSize = 1; // 기본적으로 row 1..
			listWrapperRanks = new List<wrapperRank>();
			mapSubWrapperRank = new Map<String, wrapperRank>();
		}

		public wrapperRank(String gRank, Decimal gAmount, Decimal gProbability){
			rank = gRank;
			amount = gAmount;
			probability = gProbability;

			average = amount * probability;
		}
	}

	public class wrapperRankFirst{
		public String rank1 {get; set;}
		public String rank2 {get; set;}
		public String rank3 {get; set;}
		public Decimal amount {get; set;}
		public Decimal probability {get; set;}
		public Decimal average {get; set;}

		public wrapperRankFirst(String gRank1, String gRank2, String gRank3, Decimal gAmount, Decimal gProbability){
			rank1 = gRank1;
			rank2 = gRank2;
			rank3 = gRank3;
			amount = gAmount;
			probability = gProbability;

			average = amount * probability;
		}
	}
}