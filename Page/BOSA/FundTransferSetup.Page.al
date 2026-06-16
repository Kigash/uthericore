page 50226 "Fund Transfer Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Fund Transfer Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Fund Transfer Nos."; Rec."Fund Transfer Nos.")
                {
                    ApplicationArea = All;
                }

            }
            group(Notification)
            {
                Caption = 'Notification';
                field("Notify Source Member"; Rec."Notify Source Member")
                {
                    ApplicationArea = All;
                }
                field("Source SMS Template"; Rec."Source SMS Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Source Email Template"; Rec."Source Email Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Notify Destination Member"; Rec."Notify Destination Member")
                {
                    ApplicationArea = All;
                }
                field("Destination SMS Template"; Rec."Destination SMS Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Destination Email Template"; Rec."Destination Email Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Notification Channel"; Rec."Notification Channel")
                {
                    ApplicationArea = All;
                }
            }
            group(Posting)
            {
                field("Fund Transfer Template Name"; Rec."Fund Transfer Template Name")
                {
                    ApplicationArea = All;
                }
                field("Fund Transfer Batch Name"; Rec."Fund Transfer Batch Name")
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

