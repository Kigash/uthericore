page 50375 "Agency Agent Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Agency;
    PromotedActionCategories = 'New,Process,Reports,Approval Request,Category5,Category6,Category7,Category8';
    Editable = true;
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Agent Type"; Rec."Agent Type")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;

                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = All;
                }
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Device Phone No."; Rec."Device Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Device Serial No."; Rec."Device Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Business Name"; Rec."Business Name")
                {
                    ApplicationArea = All;
                }
                field("Allow Withdrawal"; Rec."Allow Withdrawal")
                {
                    ApplicationArea = All;
                }
                field("Allow Desposit"; Rec."Allow Deposit")
                {
                    ApplicationArea = All;
                }
                field("Allow Balance Inquiry"; Rec."Allow Balance Inquiry")
                {
                    ApplicationArea = All;
                }
                field("Allow Ministatement"; Rec."Allow Ministatement")
                {
                    ApplicationArea = All;
                }
                field("Allow Airtime"; Rec."Allow Airtime")
                {
                    ApplicationArea = All;
                }
                field("Allow Utility Services"; Rec."Allow Utility Services")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            group(Audit)
            {
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                }
            }
        }

    }



    trigger OnOpenPage()
    begin

    end;

    var





}

