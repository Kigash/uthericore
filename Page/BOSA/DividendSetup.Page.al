page 50322 "Dividend Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Dividend Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Dividend Nos."; Rec."Dividend Nos.")
                {
                    ApplicationArea = All;
                }
                field("Dividend Rate %"; Rec."Dividend Rate %")
                {
                    ApplicationArea = All;
                }
                field("Interest Rate %"; Rec."Interest Rate %")
                {
                    ApplicationArea = All;
                }
                field("Commission Amount"; Rec."Commission Amount")
                {
                    ApplicationArea = All;
                }
                field("Commission G/L Account"; Rec."Commission G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Dividend Control G/L Account"; Rec."Dividend Control G/L Account")
                {
                    ApplicationArea = All;
                }
                field("FOSA Account Type"; Rec."FOSA Account Type")
                {
                    ApplicationArea = All;
                }
                field("Charge Withholdig Tax"; Rec."Charge Withholdig Tax")
                {
                    ApplicationArea = All;
                }
                field("Charge Excise Duty"; Rec."Charge Excise Duty")
                {
                    ApplicationArea = All;
                }
                field("Topup Shares"; Rec."Topup Shares")
                {
                    ApplicationArea = All;
                }
                field("Minimum Share Capital"; Rec."Minimum Share Capital")
                {
                    ApplicationArea = All;
                }
            }
            group(Notification)
            {
                Caption = 'Notification';
                field("Notify Member"; Rec."Notify Member")
                {
                    ApplicationArea = All;
                }
                field("Notification Channel"; Rec."Notification Channel")
                {
                    ApplicationArea = All;
                }
                field("Dividend SMS Template"; Rec."Dividend SMS Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Dividend Email Template"; Rec."Dividend Email Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Interest SMS Template"; Rec."Interest SMS Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Interest Email Template"; Rec."Interest Email Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }
            group(Posting)
            {
                field("Dividend Template Name"; Rec."Dividend Template Name")
                {
                    ApplicationArea = All;
                }
                field("Dividend Batch Name"; Rec."Dividend Batch Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

