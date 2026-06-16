page 50705 "Procurement Lines"
{
    // version TL2.0

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Procurement Plan Line";
	PromotedActionCategories = 'New,Process,Reports,Plan Approval,Process';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
                field("Plan No"; Rec."Plan No")
                {
                    Editable = true;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                }
                field("Current Budget"; Rec."Current Budget")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Procurement Type"; Rec."Procurement Type")
                {
                    ApplicationArea = All;
                }
                field("Procurement Sub Type"; Rec."Procurement Sub Type")
                {
                    ApplicationArea = All;
                }
                field("Source Of Funds"; Rec."Source Of Funds")
                {
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("G/L Name"; Rec."G/L Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit On Measure"; Rec."Unit On Measure")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = All;
                }
                field("Budget Amount"; Rec."Budget Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Advertisement Date"; Rec."Advertisement Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Completion Date"; Rec."Expected Completion Date")
                {
                    ApplicationArea = All;
                }
                field("Distribution Type"; Rec."Distribution Type")
                {
                    ApplicationArea = All;
                }
                field("1st Quarter"; Rec."1st Quarter")
                {
                    ApplicationArea = All;
                }
                field("2nd Quarter"; Rec."2nd Quarter")
                {
                    ApplicationArea = All;
                }
                field("3rd Quarter"; Rec."3rd Quarter")
                {
                    ApplicationArea = All;
                }
                field("4th Quarter"; Rec."4th Quarter")
                {
                    ApplicationArea = All;
                }
                field("Procurement Method"; Rec."Procurement Method")
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
            action("Forward To CEO")
            {
                Image = ChangeCustomer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = SeeCEO;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    ForwardCaption := ForwardAction;
                    SelectedOption := DIALOG.STRMENU(ForwardCaption, 1, ForwardTxt2);
                    ProcurementPlanLines.COPYFILTERS(Rec);
                    ProcurementPlanLines2.COPYFILTERS(Rec);
                    GeneralLedgerSetup.GET;
                    IF ProcurementPlanLines.FIND('-') THEN BEGIN
                        CASE SelectedOption OF
                            1:
                                BEGIN
                                    REPEAT
                                        ProcurementManagement.ForwardToCEO(ProcurementPlanLines);
                                    UNTIL ProcurementPlanLines.NEXT = 0;
                                    IF GLBudgetName.GET(GeneralLedgerSetup."Current Bugdet") THEN
                                        ProcurementManagement.UpdateGLBudget(GLBudgetName, 1);
                                    //MESSAGE(ForwardTxt1);
                                END;
                            2:
                                BEGIN
                                    ProcurementPlanLines2.SETRANGE(Select, TRUE);
                                    IF NOT ProcurementPlanLines2.FIND('-') THEN
                                        ERROR(ForwardErr1);
                                    REPEAT
                                        IF ProcurementPlanLines.Select = TRUE THEN
                                            ProcurementManagement.ForwardToCEO(ProcurementPlanLines);
                                    UNTIL ProcurementPlanLines.NEXT = 0;
                                    IF GLBudgetName.GET(GeneralLedgerSetup."Current Bugdet") THEN
                                        ProcurementManagement.UpdateGLBudget(GLBudgetName, 1);
                                    //MESSAGE(ForwardTxt1);
                                END;
                        END;
                    END;
                    CurrPage.CLOSE;
                end;
            }
            action("View Plan Dates")
            {
                Image = DueDate;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = SeeDates;
                ApplicationArea = All;

                trigger OnAction();
                begin Rec.TestField("Procurement Method");
                    ProcurementPlanLines2.COPYFILTERS(Rec);
                    CurrPage.SETSELECTIONFILTER(Rec);
                    //Rec.MARKEDONLY(TRUE);
                    ProcurementPlanLines.COPYFILTERS(Rec);
                    IF ProcurementPlanLines.FINDFIRST THEN BEGIN
                        //ProcurementManagement.ValidateProcurementDates(ProcurementPlanLines);
                        ProcurementManagement.ValidateProcurementDates(ProcurementPlanLines);
                        COMMIT;
                        CLEAR(ProcurementLinesDates);
                        ProcurementLinesDates.SETTABLEVIEW(ProcurementPlanLines);
                        ProcurementLinesDates.SETRECORD(ProcurementPlanLines);
                        ProcurementLinesDates.LOOKUPMODE := TRUE;
                        ProcurementLinesDates.RUNMODAL;
                    END;
                    CLEAR(Rec);
                    Rec.COPYFILTERS(ProcurementPlanLines2);
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        ValidateVisibility;
        UserSetup.GET(USERID);
        ProcurementSetup.GET;
        IF ProcurementSetup."Procurement Manager" <> USERID THEN BEGIN
            CurrPage.EDITABLE := FALSE;
        END;
    end;

    var
        ProcurementManagement: Codeunit "Procurement Management";
        ForwardOption: Text;
        ForwardCaption: Text;
        SelectedOption: Integer;
        ProcurementPlanHeader: Record "Procurement Plan Header";
        ProcurementPlanLines: Record "Procurement Plan Line";
        ProcurementLinesDates: Page "Procurement Lines Dates";
        ProcurementPlanLines2: Record "Procurement Plan Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        GLBudgetName: Record "G/L Budget Name";
        SeeCEO: Boolean;
        CancelMessage: Label 'Page Closed';
        ForwardAction: Label 'Submit All,Submit Selected';
        ForwardTxt1: Label 'Plans submitted Successfully.';
        ForwardTxt2: Label 'Select the forwarding option.';
        ForwardErr1: Label 'Kindly select the lines to submit';
        ProcurementSetup: Record "Procurement Setup";
        UserSetup: Record "User Setup";
        SeeDates: Boolean;

    local procedure ValidateVisibility();
    begin
        GeneralLedgerSetup.GET;
        SeeDates := TRUE;
        IF GLBudgetName.GET(GeneralLedgerSetup."Current Bugdet") THEN BEGIN
            IF GLBudgetName."Forwarded To CEO?" = TRUE THEN BEGIN
                SeeCEO := FALSE;
                CurrPage.EDITABLE := FALSE;
            END ELSE BEGIN
                SeeCEO := TRUE;
            END;
            IF GLBudgetName."Procurement Plan Approved" = TRUE THEN BEGIN
                SeeDates := FALSE;
                CurrPage.EDITABLE := FALSE;
            END;
        END;
    end;
}
