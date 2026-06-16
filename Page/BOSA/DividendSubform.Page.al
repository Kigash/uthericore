page 50315 "Dividend Subform"
{
    // version TL2.0

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    UsageCategory = Lists;
    SourceTable = "Dividend Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                    Caption = 'Ordinary Account No.';
                    ApplicationArea = All;
                }
                field("Member Deposits Amount"; Rec."Member Deposits Amount")
                {
                    Caption = 'Deposits Balance';
                    ApplicationArea = All;
                }
                field("Share Capital Amount"; Rec."Share Capital Amount")
                {
                    Caption = 'Share Capital Balance';
                    ApplicationArea = All;
                }
                field("Interest On Deposits Amount"; Rec."Interest On Deposits Amount")
                {
                    ApplicationArea = All;
                }
                field("Dividend Share Capital Amount"; Rec."Dividend Share Capital Amount")
                {
                    ApplicationArea = All;
                }
                field(January; Rec.January)
                {
                    ApplicationArea = All;
                }
                field(February; Rec.February)
                {
                    ApplicationArea = All;
                }
                field(March; Rec.March)
                {
                    ApplicationArea = All;
                }
                field(April; Rec.April)
                {
                    ApplicationArea = All;
                }
                field(May; Rec.May)
                {
                    ApplicationArea = All;
                }
                field(June; Rec.June)
                {
                    ApplicationArea = All;
                }
                field(July; Rec.July)
                {
                    ApplicationArea = All;
                }
                field(August; Rec.August)
                {
                    ApplicationArea = All;
                }
                field(September; Rec.September)
                {
                    ApplicationArea = All;
                }
                field(October; Rec.October)
                {
                    ApplicationArea = All;
                }
                field(November; Rec.November)
                {
                    ApplicationArea = All;
                }
                field(December; Rec.December)
                {
                    ApplicationArea = All;
                }
                field("Gross Earning Amount"; Rec."Gross Earning Amount")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    ApplicationArea = All;
                }
                field("Shares Topup Amount"; Rec."Shares Topup Amount")
                {
                    ApplicationArea = All;
                }
                field("Net Earning Amount"; Rec."Net Earning Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Calculate Dividends")
            {
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    DividendHeader.GET(Rec."Document No.");
                    CalculateDividends.SetDocumentNo(Rec."Document No.", DividendHeader."Calculation End Date");
                    CalculateDividends.RUN;
                end;
            }
            action("Send SMS")
            {
                Image = SendElectronicDocument;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    DividendHeader.GET(Rec."Document No.");
                    DividendHeader.TESTFIELD(Posted, TRUE);
                    DividendHeader.SETRECFILTER;
                    REPORT.RUN(REPORT::"Send Dividend Notice", TRUE, FALSE, DividendHeader)
                end;
            }
        }
    }

    var
        CalculateDividends: Report "Calculate Dividends";
        DividendHeader: Record "Dividend Header";
        AccountType: Record "Account Type";
}