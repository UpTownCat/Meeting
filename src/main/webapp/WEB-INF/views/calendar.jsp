<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<div id="Demo">
					<div id="CalendarMain">
						<div id="title">
							<div class="selectBtn month" href="javascript:"
								onclick="CalendarHandler.CalculateLastMonthDays();"><</div><div
								class="selectBtn selectYear" href="javascript:"
								onClick="CalendarHandler.CreateSelectYear(CalendarHandler.showYearStart);">2014��</div><div
								class="selectBtn selectMonth"
								onClick="CalendarHandler.CreateSelectMonth()">6��</div> <div
								class="selectBtn nextMonth" href="javascript:"
								onClick="CalendarHandler.CalculateNextMonthDays();">></div><div
								class="selectBtn currentDay" href="javascript:"
								onClick="CalendarHandler.CreateCurrentCalendar(0,0,0);">����</div>
						</div>
						<div id="context">
							<div class="week">
								<h3>һ</h3>
								<h3>��</h3>
								<h3>��</h3>
								<h3>��</h3>
								<h3>��</h3>
								<h3>��</h3>
								<h3>��</h3>
							</div>
							<div id="center">
								<div id="centerMain">
									<div id="selectYearDiv"></div>
									<div id="centerCalendarMain">
										<div id="Container"></div>
									</div>
									<div id="selectMonthDiv"></div>
								</div>
							</div>
							<div id="foots">
								<h5>
									<h5 id="footNow" style="float: left"></h5>
									<label style="float:right">
										<a style="text-decoration: none" href="" id="weekView"><button type="button">����ͼ</button></a>
										<a style="text-decoration: none" href="" id="monthView"><button type="button">����ͼ</button></a>
									</label>
								</h5>
							</div>
						</div>
					</div>
				</div>