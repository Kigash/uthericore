page 50292 "Member Remittance Advice"
{
    // version TL2.0

    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Member Remittance Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
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
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Time"; Rec."Last Modified Time")
                {
                    ApplicationArea = All;
                }
            }
            part(Page; 50293)
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            part(AttachmentFactBox; 50265)
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action(Print)
            {
                Image = BankAccountStatement;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    MemberRemittanceHeader.GET(Rec."No.");
                    MemberRemittanceHeader.SETRECFILTER;
                    //REPORT.RUN(REPORT::"Member Remittance Advice", TRUE, FALSE, MemberRemittanceHeader);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.AttachmentFactBox.PAGE.SetParameter(Rec.RECORDID, Rec."No.");
    end;

    var
        MemberRemittanceHeader: Record "Member Remittance Header";
}

