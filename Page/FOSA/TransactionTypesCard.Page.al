page 50025 "Transaction Types Card"
{
    // version TL2.0

    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Charges,Approval Request,Comments,Category 7,Category 8';
    SourceTable = "Transaction -Type";

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
                field("Application Area"; Rec."Application Area")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Service ID"; Rec."Service ID")
                {
                    ApplicationArea = All;
                }
                field("Calculation Method"; Rec."Calculation Method")
                {
                    ApplicationArea = All;
                }
                group(SACCO)
                {
                    //The GridLayout property is only supported on controls of type Grid
                    //GridLayout = Columns;
                    field("Settlement Account Type"; Rec."Settlement Account Type")
                    {
                        ApplicationArea = All;
                    }
                    field("Settlement Account No."; Rec."Settlement Account No.")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(Posting)
            {
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Columns;
                field("Priority Posting"; Rec."Priority Posting")
                {

                    trigger OnValidate()
                    begin
                        IF Rec."Priority Posting" THEN
                            ShowPriorityPosting := TRUE
                        ELSE
                            ShowPriorityPosting := FALSE;
                    end;
                }
                group("Control Account")
                {
                    field("Sett. Control Account Type"; Rec."Sett. Control Account Type")
                    {
                    }
                    field("Sett. Control Account No."; Rec."Sett. Control Account No.")
                    {
                    }
                }
                group(TL)
                {
                    //The GridLayout property is only supported on controls of type Grid
                    //GridLayout = Columns;
                    field("Settlement2 Account Type"; Rec."Settlement2 Account Type")
                    {
                    }
                    field("Settlement2 Account No."; Rec."Settlement2 Account No.")
                    {
                    }
                }
                group(COOP)
                {
                    Visible = Rec."Application Area" = 2;
                    field("Settlement3 Account No."; Rec."Settlement3 Account No.")
                    {
                    }
                    field("Settlement3 Account Type"; Rec."Settlement3 Account Type")
                    {
                    }
                }
                group(AGENT)
                {
                    Visible = Rec."Application Area" = 3;
                    field("Settlement4 Account Type"; Rec."Settlement4 Account Type")
                    {
                    }
                }
                group("Statutory Deductions")
                {
                    field("Deduct Excise Duty"; Rec."Deduct Excise Duty")
                    {
                    }
                    field("Deduct Stamp Duty"; Rec."Deduct Stamp Duty")
                    {
                    }
                    field("Deduct Withholding Tax"; Rec."Deduct Withholding Tax")
                    {
                    }
                    field("Charge Penalty"; Rec."Charge Penalty")
                    {
                    }
                }

            }
            part(TransactionChargesFlat; "Transaction Charges-Flat")
            {
                SubPageLink = "Transaction Type Code" = FIELD(Code);
                //Visible = "Calculation Method" = 0;
                Visible = true;
                ApplicationArea = All;

            }
            part(TransactionChargesPercent; "Transaction Charges-Percent")
            {
                SubPageLink = "Transaction Type Code" = FIELD(Code);
                //Visible = "Calculation Method" = 1;
                Visible = true;
                ApplicationArea = All;
            }
            part(Charges; Charges)
            {
                SubPageLink = Type = FIELD(Type);
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Transaction Charges")
            {
                Image = ProdBOMMatrixPerVersion;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                Visible = false;
                // RunObject = Page "Transaction Charges";
                // RunPageLink = "Transaction Type Code" = FIELD(Code);
                trigger OnAction()
                begin


                end;
            }
            action("Priority Posting2")
            {
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                //RunObject = Page pri;
                // RunPageLink = "Transaction Type" = FIELD(Code);
                Visible = ShowPriorityPosting;
            }
        }
    }

    trigger OnOpenPage()
    begin
        // SetVisible;
    end;



    var
        TransactionCharge: Record "Transaction Charge";
        IsSaccoGroupVisible: Boolean;
        IsTLGroupVisible: Boolean;
        IsCOOPGroupVisible: Boolean;
        IsAgentGroupVisible: Boolean;
        ShowPriorityPosting: Boolean;
        IsFlatPageVisible: Boolean;
        IsPercentPageVisible: Boolean;


}

