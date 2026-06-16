page 50928 "Performance Contract Header"
{
    Caption = 'Performance Contract';
    PageType = Card;
    SourceTable = "Performance Contract";


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Appraisal Year"; Rec."Appraisal Year")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec."Branch Name")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field("Apprasier No."; Rec."Apprasier No.")
                {
                    ApplicationArea = All;
                }
                field("Appraiser Name"; Rec."Appraiser Name")
                {
                    ApplicationArea = All;
                }
                field("Appraiser Job Title"; Rec."Appraiser Job Title")
                {
                    ApplicationArea = All;
                }
            }
            part("Quantitative Goals"; "Quantitative Goals Lines")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = all;
            }
            part("Qualitative Goals"; "Qualitative Goals Lines")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Submit Contract")
            {
                Image = SendConfirmation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = Rec.Submitted = false;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF CONFIRM(StrSubstNo(Text000, Rec."Appraisal Year")) THEN BEGIN
                        Rec.Submitted := true;
                        Rec.MODIFY();
                        MESSAGE(Text001);
                        CurrPage.CLOSE;
                    END;
                end;
            }
        }
    }
    var
        Text000: Label 'Are you sure you want to submit your performance contract for period %1?';
        Text001: Label 'Submitted successfully!';

    trigger OnOpenPage()
    begin
        if Rec.Submitted then
            CurrPage.Editable(false);
    end;
}
