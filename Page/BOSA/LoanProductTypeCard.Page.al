page 50212 "Loan Product Type Card"
{
    // version TL2.0

    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Related Information,Approval Request,Comments,Category 7,Category 8';
    SourceTable = "Loan Product Type";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = All;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = All;
                }
                field("Repayment Period"; Rec."Repayment Period")
                {
                    ApplicationArea = All;
                }
                field("Grace Period"; Rec."Grace Period")
                {
                    ApplicationArea = All;
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    ApplicationArea = All;
                }
                field("Min. Loan Amount"; Rec."Min. Loan Amount")
                {
                    ApplicationArea = All;
                }
                field("Max. Loan Amount"; Rec."Max. Loan Amount")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Min. Membership period"; Rec."Min. Membership period")
                {
                    ApplicationArea = All;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = All;
                }
                field("E-Loan"; Rec."E-Loan")
                {
                    ApplicationArea = All;
                }
                field("Security Type"; Rec."Security Type")
                {
                    ApplicationArea = All;
                }
                field("Board/Staff"; Rec."Board/Staff")
                {
                    ApplicationArea = All;
                }
                field("Apply Graduation Schedule"; Rec."Apply Graduation Schedule")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ValidateLoanProduct;
                    end;
                }

                field("Based on Deposits"; Rec."Based on Deposits")
                {
                    ApplicationArea = All;
                }
                group(Deposit)
                {
                    Caption = '';
                    Visible = Rec."Based on Deposits" = TRUE;

                    field("Loan Deposit Ratio"; Rec."Loan Deposit Ratio")
                    {
                        ApplicationArea = All;
                    }
                    field("Apply Special Ratio-Deposits"; Rec."Apply Special Ratio-Deposits")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Based on Shares"; Rec."Based on Shares")
                {
                    ApplicationArea = All;
                }
                group(Shares)
                {
                    Caption = '';
                    Visible = Rec."Based on Shares" = TRUE;

                    field("Loan Shares Ratio"; Rec."Loan Shares Ratio")
                    {
                        ApplicationArea = All;
                    }
                    field("Apply Special Ratio-Shares"; Rec."Apply Special Ratio-Shares")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Based on Savings"; Rec."Based on Savings")
                {
                    ApplicationArea = All;
                }
                group(Savings)
                {
                    Caption = '';
                    Visible = Rec."Based on Savings" = TRUE;

                    field("Loan Savings Ratio"; Rec."Loan Savings Ratio")
                    {
                        ApplicationArea = All;
                    }
                    field("Apply Special Ratio-Savings"; Rec."Apply Special Ratio-Savings")
                    {
                        ApplicationArea = All;
                    }
                }


                field("Allow Multiple Loans"; Rec."Allow Multiple Loans")
                {
                    ApplicationArea = All;
                }
                field("Turn Around Time"; Rec."Turn Around Time")
                {
                    ApplicationArea = All;
                }

                field("Paybill Short Code"; Rec."Paybill Short Code")
                {
                    ApplicationArea = All;
                }
                group(EloanThreshHold)
                {
                    Caption = '';
                    Visible = Rec."E-Loan" = true;
                    field("E-Loan Threshold"; Rec."E-Loan Threshold")
                    {
                        ApplicationArea = All;
                    }
                }
                field("No. of Guarantors"; Rec."No. of Guarantors")
                {
                    ApplicationArea = All;
                }

                field("Recovery Method"; Rec."Recovery Method")
                {
                    ApplicationArea = All;
                }
                group(RecoverOnSpecificDay)
                {
                    Caption = '';
                    Visible = Rec."Recovery Method" = 2;
                    field("Recovery Day"; Rec."Recovery Day")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Apply Special Recovery Method"; Rec."Apply Special Recovery Method")
                {
                    ApplicationArea = All;
                }


                field("Allow Refinancing"; Rec."Allow Refinancing")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ValidateLoanProduct;
                    end;
                }
                group(Refinancing)
                {
                    Caption = '';
                    Visible = Rec."Allow Refinancing" = TRUE;
                    field("Refinancing Mode"; Rec."Refinancing Mode")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Apply Special Repayment Rates"; Rec."Apply Special Repayment Rates")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ValidateLoanProduct;
                    end;
                }
                field("Boost on Recovery"; Rec."Boost on Recovery")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ValidateLoanProduct;
                    end;
                }
                field("Apply Induplum Rule"; Rec."Apply Induplum Rule")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            group(Posting)
            {
                field("Loan Posting Group"; Rec."Loan Posting Group")
                {
                    ApplicationArea = All;
                }

                field("Interest Due Posting Group"; Rec."Interest Due Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Interest Paid Posting Group"; Rec."Interest Paid Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Ledger Fee Due Posting Group"; Rec."Ledger Fee Due Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Ledger Fee Paid Posting Group"; Rec."Ledger Fee Paid Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Interest Capitalization Method"; Rec."Interest Capitalization Method")
                {
                    ApplicationArea = All;
                }
                group(CapitalizeSpecificDay)
                {
                    Caption = '';
                    Visible = Rec."Interest Capitalization Method" = 1;
                    field("Interest Cap. Day"; Rec."Interest Cap. Day")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Apply Special Int. Cap Method"; Rec."Apply Special Int. Cap Method")
                {
                    ApplicationArea = All;
                }

                field("Charge Penalty on Defaulters"; Rec."Charge Penalty on Defaulters")
                {
                    ApplicationArea = All;
                }
                group(Penalty)
                {
                    Caption = '';
                    Visible = Rec."Charge Penalty on Defaulters";

                    field("Penalty Due Posting Group"; Rec."Penalty Due Posting Group")
                    {
                        ApplicationArea = All;
                    }
                    field("Penalty Paid Posting Group"; Rec."Penalty Paid Posting Group")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Loan Charges")
            {
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    LoanCharge.FILTERGROUP(10);
                    LoanCharge.SETRANGE("Loan Product Type", Rec.Code);
                    LoanCharge.FILTERGROUP(0);
                    PAGE.RUN(50214, LoanCharge);
                end;
            }
            action("Special Repayment Rates")
            {
                Image = Price;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsMoreRatesVisible;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    LoanRates.FILTERGROUP(10);
                    LoanRates.SETRANGE("Loan Product Type", Rec.Code);
                    LoanRates.FILTERGROUP(0);
                    PAGE.RUN(50215, LoanRates);
                end;
            }
            action("Refinancing Charges")
            {
                Image = FinChargeMemo;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page 50225;
                RunPageLink = "Loan Product Code" = FIELD(Code);
                Visible = IsRefinancingChargeVisible;
                ApplicationArea = All;
            }
            action("Graduation Schedule")
            {
                Image = IssueFinanceCharge;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page 50218;
                RunPageLink = "Loan Product Code" = FIELD(Code);
                Visible = IsGraduationScheduleVisible;
                ApplicationArea = All;
            }
            action("Boost Account Types")
            {
                Image = GiroPlus;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page 50335;
                RunPageLink = "Loan Product Type" = FIELD(Code);
                Visible = IsBoostAccountTypeVisible;
                ApplicationArea = All;
            }
            action("SpecialDSSRatio")
            {
                Caption = 'Special DSS Ratio';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                Visible = Rec."Apply Special Ratio-Deposits";
                RunObject = Page 51332;
                RunPageLink = "Loan Product Code" = FIELD(Code);
                trigger OnAction()
                begin

                end;
            }
            action("SpecialLoanRecovery")
            {
                Caption = 'Special Loan Recovery';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                RunObject = Page 51333;
                Visible = Rec."Apply Special Recovery Method";
                RunPageLink = "Loan Product Code" = FIELD(Code);
                trigger OnAction()
                begin

                end;
            }
            action("SpecialInterestCapDay")
            {
                Caption = 'Special Interest Cap.';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                RunObject = Page 51334;
                Visible = Rec."Apply Special Int. Cap Method";
                RunPageLink = "Loan Product Code" = FIELD(Code);
                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        ValidateLoanProduct;
    end;

    var
        LoanCharge: Record "Loan Product Charge";
        LoanRates: Record "LP Special Repayment Rate";
        IsMoreRatesVisible: Boolean;
        IsGraduationScheduleVisible: Boolean;
        IsRefinancingChargeVisible: Boolean;
        IsBoostAccountTypeVisible: Boolean;

    local procedure ValidateLoanProduct()
    begin
        IF Rec."Apply Special Repayment Rates" THEN
            IsMoreRatesVisible := TRUE
        ELSE
            IsMoreRatesVisible := FALSE;

        IF Rec."Apply Graduation Schedule" THEN
            IsGraduationScheduleVisible := TRUE
        ELSE
            IsGraduationScheduleVisible := FALSE;

        IF Rec."Allow Refinancing" THEN
            IsRefinancingChargeVisible := TRUE
        ELSE
            IsRefinancingChargeVisible := FALSE;

        IF Rec."Boost on Recovery" THEN
            IsBoostAccountTypeVisible := TRUE
        ELSE
            IsBoostAccountTypeVisible := FALSE;
    end;
}

