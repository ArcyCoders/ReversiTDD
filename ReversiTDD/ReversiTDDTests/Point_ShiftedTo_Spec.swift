//
//  Point_ShiftedTo_Spec.swift
//  ReversiTDD
//
//  Created by Krzysztof Moczała on 07/10/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Quick
import Nimble


class Point_ShiftedTo_Spec: QuickSpec {
    override func spec() {
        describe("shifted(to:)") {
            describe("right") {
                context("when it can be shifted") {
                    it("returns the shifted point") {
                        let point = Point(x: .a, y: ._1)

                        let shifted = point.shifted(to: .right)

                        expect(shifted).to(equal(Point(x: .b, y: ._1)))
                    }
                }

                context("when it cannot be shifted") {
                    it("returns nil") {
                        let point = Point(x: .h, y: ._1)

                        let shifted = point.shifted(to: .right)

                        expect(shifted).to(beNil())
                    }
                }
            }

            describe("left") {
                context("when it can be shifted") {
                    it("returns the shifted point") {
                        let point = Point(x: .b, y: ._1)

                        let shifted = point.shifted(to: .left)

                        expect(shifted).to(equal(Point(x: .a, y: ._1)))
                    }
                }

                context("when it cannot be shifted") {
                    it("returns nil") {
                        let point = Point(x: .a, y: ._1)

                        let shifted = point.shifted(to: .left)

                        expect(shifted).to(beNil())
                    }
                }
            }

            describe("top") {
                context("when it can be shifted") {
                    it("returns the shifted point") {
                        let point = Point(x: .a, y: ._1)

                        let shifted = point.shifted(to: .top)

                        expect(shifted).to(equal(Point(x: .a, y: ._2)))
                    }
                }

                context("when it cannot be shifted") {
                    it("returns nil") {
                        let point = Point(x: .a, y: ._8)

                        let shifted = point.shifted(to: .top)

                        expect(shifted).to(beNil())
                    }
                }
            }

            describe("bottom") {
                context("when it can be shifted") {
                    it("returns the shifted point") {
                        let point = Point(x: .a, y: ._2)

                        let shifted = point.shifted(to: .bottom)

                        expect(shifted).to(equal(Point(x: .a, y: ._1)))
                    }
                }

                context("when it cannot be shifted") {
                    it("returns nil") {
                        let point = Point(x: .a, y: ._1)

                        let shifted = point.shifted(to: .bottom)

                        expect(shifted).to(beNil())
                    }
                }
            }

            describe("topLeft") {
                context("when it can be shifted") {
                    it("returns the shifted point") {
                        let point = Point(x: .b, y: ._1)

                        let shifted = point.shifted(to: .topLeft)

                        expect(shifted).to(equal(Point(x: .a, y: ._2)))
                    }
                }

                context("when it cannot be shifted") {
                    it("returns nil") {
                        let point = Point(x: .a, y: ._1)

                        let shifted = point.shifted(to: .topLeft)

                        expect(shifted).to(beNil())
                    }
                }
            }

            describe("topRight") {
                context("when it can be shifted") {
                    it("returns the shifted point") {
                        let point = Point(x: .a, y: ._1)

                        let shifted = point.shifted(to: .topRight)

                        expect(shifted).to(equal(Point(x: .b, y: ._2)))
                    }
                }

                context("when it cannot be shifted") {
                    it("returns nil") {
                        let point = Point(x: .h, y: ._1)

                        let shifted = point.shifted(to: .topRight)

                        expect(shifted).to(beNil())
                    }
                }
            }

            describe("bottomLeft") {
                context("when it can be shifted") {
                    it("returns the shifted point") {
                        let point = Point(x: .b, y: ._2)

                        let shifted = point.shifted(to: .bottomLeft)

                        expect(shifted).to(equal(Point(x: .a, y: ._1)))
                    }
                }

                context("when it cannot be shifted") {
                    it("returns nil") {
                        let point = Point(x: .h, y: ._1)

                        let shifted = point.shifted(to: .bottomLeft)

                        expect(shifted).to(beNil())
                    }
                }
            }

            describe("bottomRight") {
                context("when it can be shifted") {
                    it("returns the shifted point") {
                        let point = Point(x: .a, y: ._2)

                        let shifted = point.shifted(to: .bottomRight)

                        expect(shifted).to(equal(Point(x: .b, y: ._1)))
                    }
                }

                context("when it cannot be shifted") {
                    it("returns nil") {
                        let point = Point(x: .h, y: ._1)

                        let shifted = point.shifted(to: .bottomRight)

                        expect(shifted).to(beNil())
                    }
                }
            }
        }
    }
}
